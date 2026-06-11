.. |br| raw:: html

   <br />

.. _falcon-rdma-image:

##########################################
Falcon RDMA and the GCHP Compute Image
##########################################

This page documents the published ``gchp-h4d-rocky8`` image, how to
use it in your own GCP project, and - for advanced users - how to
rebuild it from scratch.

.. important::
   If you only want to **use** the image, you can stop after
   Sections 1-2. Sections 3-7 are for users building a custom image
   (e.g., adding extra system packages or a newer GCHP version).


================================================================================
1. About the published image
================================================================================

.. list-table::
   :header-rows: 1
   :widths: 28 72

   * - Field
     - Value
   * - Image family
     - ``gchp-h4d-rocky8``
   * - Latest image name
     - ``gchp-h4d-rocky8-v2``
   * - Hosting project
     - ``eece-acag``
   * - Base OS
     - Rocky Linux 8.10 with CIQ kernel
   * - Disk size
     - 20 GB
   * - RDMA support
     - Intel iRDMA (Falcon)
   * - Optimized for
     - ``h4d-standard-192``

The image is **portable across every GCP region and zone** that
supports ``h4d-standard-192``. You boot it the same way regardless
of where you deploy.

.. note::
   The image does **not** include the Spack stack, OpenMPI, or the
   GCHP binary itself. Those live on Filestore NFS so a single build
   is shared across compute nodes. See :ref:`set-up-gcp-cluster` for
   the build instructions.


================================================================================
2. Using the image
================================================================================

2a. As a Slurm-GCP compute image (recommended)
--------------------------------------------------------------------------------

Add this to your ``gchp-cluster.yaml`` blueprint:

.. code-block:: yaml

   - id: h4d_nodeset
     source: community/modules/compute/schedmd-slurm-gcp-v6-nodeset
     use: [network]
     settings:
       node_count_dynamic_max: 4
       machine_type: h4d-standard-192
       maintenance_policy: TERMINATE
       instance_image:
         family: gchp-h4d-rocky8                  # public family
         project: eece-acag                       # public project

When Slurm bursts a new H4D node, it boots from the latest image in
the family. Boot time is ~90 seconds, after which ``irdma`` is
loaded and Falcon RDMA is ready.

2b. As a standalone VM (one-off testing)
--------------------------------------------------------------------------------

.. code-block:: bash

   gcloud compute instances create gchp-test \
       --zone=us-central1-a \
       --machine-type=h4d-standard-192 \
       --maintenance-policy=TERMINATE \
       --image-family=gchp-h4d-rocky8 \
       --image-project=eece-acag \
       --network-interface=network=default,subnet=default,nic-type=GVNIC

For multi-node Falcon RDMA, attach the iRDMA NIC on a second
interface:

.. code-block:: bash

   gcloud compute instances create gchp-test \
       --zone=us-central1-a \
       --machine-type=h4d-standard-192 \
       --maintenance-policy=TERMINATE \
       --image-family=gchp-h4d-rocky8 \
       --image-project=eece-acag \
       --network-interface=network=default,subnet=default,nic-type=GVNIC \
       --network-interface=network=gchp-falcon-net,subnet=gchp-falcon-subnet,nic-type=IRDMA,no-address

2c. First-boot configuration via instance metadata
--------------------------------------------------------------------------------

The image runs a one-shot systemd unit at first boot called
``gchp-first-boot.service``. It reads four metadata attributes to
configure the node:

.. list-table::
   :header-rows: 1
   :widths: 22 22 56

   * - Metadata key
     - Default
     - Effect
   * - ``enable-irdma``
     - ``true``
     - Load ``idpf`` and ``irdma`` modules
   * - ``nfs-server``
     - (empty)
     - If set, mount this NFS server at boot
   * - ``nfs-share``
     - ``/nfsshare``
     - NFS share name
   * - ``nfs-mount``
     - ``/shared``
     - Where to mount it

To auto-mount your Filestore at boot:

.. code-block:: bash

   gcloud compute instances create gchp-test \
       ... \
       --metadata='nfs-server=10.176.150.18,nfs-share=/nfsshare,nfs-mount=/shared'

In a Slurm-GCP blueprint, set the same metadata under the nodeset:

.. code-block:: yaml

   settings:
     metadata:
       nfs-server: "10.176.150.18"
       nfs-share: "/nfsshare"
       nfs-mount: "/shared"

.. tip::
   If you let Cluster Toolkit create the Filestore via the
   ``homefs`` module, ``/shared`` is mounted **automatically** via
   Slurm-GCP's machinery. You do not need to set the ``nfs-*``
   metadata in that case. The metadata is intended for advanced
   setups where you bring an existing Filestore to a fresh project.


================================================================================
3. Verifying Falcon RDMA after boot
================================================================================

.. code-block:: bash

   $ gcloud compute ssh gchp-test --command='ibv_devinfo | head'
   hca_id: irdma0
       transport:    InfiniBand (0)
       fw_ver:       1.3705
       state:        PORT_ACTIVE (4)        # <- Falcon RDMA ready
       max_mtu:      4096 (5)
       active_mtu:   4096 (5)
       link_layer:   Ethernet

If the state is ``PORT_DOWN`` or the device is not found:

.. list-table::
   :header-rows: 1
   :widths: 28 32 40

   * - Symptom
     - Likely cause
     - Fix
   * - ``Failed to open device``
     - Custom rebuild without the Rocky iRDMA provider
     - Re-apply the provider swap (Section 5b)
   * - ``no devices found``
     - IRDMA NIC not attached at create time
     - Add second ``--network-interface`` with ``nic-type=IRDMA``
   * - ``PORT_DOWN``
     - NIC up but Falcon subnet wrong
     - Verify subnet uses ``<zone>-vpc-falcon`` profile


================================================================================
4. Supported zones (Falcon RDMA)
================================================================================

As of 2026-06, Falcon RDMA is offered in:

* ``asia-southeast1-a``
* ``europe-west4-b``
* ``us-central1-a``
* ``us-central1-b``
* ``us-west4-a``

To get the current list at any time:

.. code-block:: bash

   gcloud compute network-profiles list | grep falcon

.. note::
   H4D capacity is tighter than common machine types like c2/n2.
   You may hit ``ZONE_RESOURCE_POOL_EXHAUSTED`` even when one zone
   is listed. In that case retry in another supported zone, or use
   **Dynamic Workload Scheduler Flex Start** to queue your request:

   .. code-block:: bash

      gcloud compute instances bulk create \
          --provisioning-model=FLEX_START \
          --max-run-duration=2h \
          ...


================================================================================
5. Building the MPI stack with Spack
================================================================================

.. important::
   The published image does not include OpenMPI or GCHP. Build them
   once into ``/shared`` (Filestore). Every burst compute node sees
   the same binaries over NFS.


5a. Spack environment
--------------------------------------------------------------------------------

After SSHing into a compute node:

.. code-block:: bash

   source /shared/spack/share/spack/setup-env.sh
   spack env create gchp-env
   spack env activate gchp-env

Save the following as
``/shared/spack/var/spack/environments/gchp-env/spack.yaml``:

.. code-block:: yaml

   spack:
     specs:
     - cmake
     - binutils
     - udunits
     - ucx +verbs+rdmacm+rc+ud+thread_multiple ^rdma-core@47.1~pyverbs
     - openmpi@4.1.6+pmi fabrics=ucx schedulers=slurm %gcc@11.5.0 ^ucx +verbs+rdmacm+rc+ud+thread_multiple ^rdma-core@47.1~pyverbs
     - hdf5+hl+mpi %gcc@11.5.0 ^openmpi@4.1.6 fabrics=ucx ^ucx +verbs+rdmacm+rc+ud+thread_multiple ^rdma-core@47.1~pyverbs
     - netcdf-c+mpi %gcc@11.5.0 ^openmpi@4.1.6 fabrics=ucx ^ucx +verbs+rdmacm+rc+ud+thread_multiple ^rdma-core@47.1~pyverbs
     - netcdf-fortran %gcc@11.5.0 ^openmpi@4.1.6 fabrics=ucx ^ucx +verbs+rdmacm+rc+ud+thread_multiple ^rdma-core@47.1~pyverbs
     - parallelio %gcc@11.5.0 ^openmpi@4.1.6 fabrics=ucx ^ucx +verbs+rdmacm+rc+ud+thread_multiple ^rdma-core@47.1~pyverbs
     - esmf %gcc@11.5.0 ^openmpi@4.1.6 fabrics=ucx ^ucx +verbs+rdmacm+rc+ud+thread_multiple ^rdma-core@47.1~pyverbs
     view: false
     concretizer:
       unify: false
     packages:
       all:
         require: '%gcc@11.5.0'
       rdma-core:
         require: ['@47.1~pyverbs']

Then build (this takes ~30 minutes on an H4D node):

.. code-block:: bash

   spack -e gchp-env concretize -f
   spack -e gchp-env install --fail-fast -j 80


5b. The iRDMA provider swap
--------------------------------------------------------------------------------

.. warning::
   This is the single non-obvious step in the entire setup. **The
   published image has it already applied.** You only need this if
   you are building your own image from scratch, or rebuilding
   rdma-core from source.

The upstream Spack ``rdma-core@47.1`` ships a generic Intel iRDMA
provider that fails to open the kernel device on Rocky Linux 8
because the upstream tarball lacks the Rocky/CIQ-specific patches.
The fix is to replace the Spack provider with the system one:

.. code-block:: bash

   RDMA=$(spack location -i /rdma-core@47.1)
   sudo cp /usr/lib64/libibverbs/libirdma-rdmav34.so \
           $RDMA/lib64/libibverbs/libirdma-rdmav34.so
   ibv_devinfo                                       # should now show PORT_ACTIVE

After this, UCX built against this rdma-core sees
``rc_verbs/irdma0:1`` and Falcon RDMA works end-to-end.


================================================================================
6. Building GCHP
================================================================================

.. code-block:: bash

   # 1. Source
   cd /shared
   git clone --recurse-submodules https://github.com/geoschem/GCHP
   cd GCHP
   git checkout 14.7.0          # or your target version

   # 2. Run directory
   cd /shared/GCHP/run
   ./createRunDir.sh             # answer the prompts

   # 3. Compile
   source /shared/spack/share/spack/setup-env.sh
   spack env activate gchp-env
   spack load /<hdf5> /<netcdf-c> /<netcdf-f> /<esmf> /<parallelio> udunits /<openmpi>

   OMPI=$(spack location -i /<openmpi-hash>)
   cd /shared/rundir-<your-rundir>
   mkdir -p build && cd build
   cmake -DRUNDIR=.. \
         -DCMAKE_C_COMPILER=$OMPI/bin/mpicc \
         -DCMAKE_CXX_COMPILER=$OMPI/bin/mpicxx \
         -DCMAKE_Fortran_COMPILER=$OMPI/bin/mpifort \
         /shared/GCHP
   make -j 30 && make install

Verify the binary picks up the right libraries:

.. code-block:: bash

   ldd ../gchp | grep -E "openmpi|esmf|netcdf|hdf5"
   # Every line should resolve to /shared/spack/opt/spack/.../<your hashes>


================================================================================
7. Building your own image (advanced)
================================================================================

To produce a custom image (e.g., GCHP 15.0.0 or a different ESMF
version):

1. Boot a fresh H4D from the published image
2. Install/modify whatever you need
3. Apply the iRDMA provider swap (Section 5b)
4. Sanitize the VM (remove your user, machine-id, SSH host keys,
   logs, shell history)
5. Stop the VM
6. Create a new image:

   .. code-block:: bash

      gcloud compute images create gchp-h4d-rocky8-v3 \
          --source-disk=<your-vm-name> \
          --source-disk-zone=us-central1-a \
          --family=gchp-h4d-rocky8 \
          --description="GCHP image v3 - adds <whatever changed>"

Same family means Slurm-GCP auto-picks the newest image. Deprecate
old versions with:

.. code-block:: bash

   gcloud compute images deprecate gchp-h4d-rocky8-v2 \
       --state=DEPRECATED \
       --replacement=gchp-h4d-rocky8-v3


================================================================================
8. Reference performance
================================================================================

Measured on ``h4d-standard-192``, GCHP 14.7.0 fullchem, 7-day
simulation from 2019-07-01:

.. list-table::
   :header-rows: 1
   :widths: 16 12 12 24 14 22

   * - Resolution
     - Cores
     - Nodes
     - Fabric
     - Wall time
     - Throughput (sim-days/day)
   * - C48
     - 96
     - 1
     - SHM
     - 1.4 h
     - 124
   * - C90
     - 180
     - 1
     - SHM
     - 2.9 h
     - 59
   * - **C90**
     - **360**
     - **2**
     - **Falcon RDMA**
     - **1.9 h**
     - **96**
   * - C180
     - 120
     - 1
     - SHM
     - 16.5 h
     - 10.2

Strong-scaling efficiency from 180 -> 360 cores on C90: **71%** of
ideal. This is representative of what to expect when Falcon RDMA is
correctly engaged.
