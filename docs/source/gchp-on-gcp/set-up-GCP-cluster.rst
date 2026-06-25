.. |br| raw:: html

   <br />

.. _set-up-gcp-cluster:

##########################################
Quickstart II: Set up your GCP HPC Cluster
##########################################

.. warning::
   A running cluster (even idle) costs approximately **$18/day** for
   Filestore plus the always-on controller and login VMs. Each H4D
   compute node adds approximately **$10/hour** while running. If you
   forget to stop the cluster, a month of idle time alone is
   approximately **$540**.

This guide walks you through deploying an HPC cluster on Google
Cloud that can run GCHP at production scale. It assumes you have
completed :ref:`prepare-gcp-environment`: your project is created
and billed, with IAM, APIs, and quotas in place, and the local
toolchain (``gcloud``, ``terraform``, ``gcluster``) is installed.


================================================================================
Workflow
================================================================================

.. list-table::
   :header-rows: 1
   :widths: 6 50 14 30

   * - Step
     - What it does
     - Time
     - Cost
   * - 1
     - Write the cluster blueprint
     - 5 min
     - $0
   * - 2
     - Deploy the cluster
     - 10-15 min
     - starts ~$18/day baseline
   * - 3
     - (Optional) Add Falcon RDMA networking
     - 2 min
     - $0
   * - 4
     - Boot compute nodes from the GCHP image
     - 90 s/node
     - $10/hr/node while up
   * - 5
     - Build GCHP
     - 30-60 min
     - compute time
   * - 6
     - Run GCHP
     - varies
     - as priced


================================================================================
1. Create an HPC Cluster Blueprint
================================================================================

A **blueprint** is a YAML file that Cluster Toolkit converts to
Terraform modules and applies. It defines:

* A regional VPC and subnet
* A Filestore NFS volume mounted at ``/shared``
* One or more **compute partitions** (machine types, max node count)
* A **controller** VM running ``slurmctld``
* A **login** VM where users SSH in

Save the following as ``gchp-cluster.yaml``. Replace ``<PROJECT_ID>``
with your project ID from :ref:`prepare-gcp-environment`. Other
placeholders are sensible defaults you can leave alone.

.. code-block:: yaml

   blueprint_name: gchp-cluster

   vars:
     project_id: <PROJECT_ID>
     deployment_name: gchpslurm
     region: us-central1
     zone: us-central1-a

   deployment_groups:
   - group: primary
     modules:

     # 1. Networking
     - id: network
       source: modules/network/vpc

     # 2. NFS shared file system
     - id: homefs
       source: community/modules/file-system/filestore
       use: [network]
       settings:
         filestore_tier: BASIC_HDD
         size_gb: 1024
         local_mount: /shared

     # 3. Compute partition - c2-standard-60 baseline
     - id: c2_nodeset
       source: community/modules/compute/schedmd-slurm-gcp-v6-nodeset
       use: [network]
       settings:
         node_count_dynamic_max: 10
         machine_type: c2-standard-60
         instance_image:
           family: slurm-gcp-6-9-hpc-rocky-linux-8
           project: schedmd-slurm-public

     - id: compute_partition
       source: community/modules/compute/schedmd-slurm-gcp-v6-partition
       use: [c2_nodeset]
       settings:
         partition_name: compute
         is_default: true

     # 4. H4D partition with the published GCHP image
     - id: h4d_nodeset
       source: community/modules/compute/schedmd-slurm-gcp-v6-nodeset
       use: [network]
       settings:
         node_count_dynamic_max: 4
         machine_type: h4d-standard-192
         bandwidth_tier: tier_1_enabled
         instance_image:
           family: gchp1470-full-v2                  # the published GCHP image
           project: eece-acag                     # the ACAG project that hosts it
         maintenance_policy: TERMINATE            # H4D doesn't support live-migration

     - id: h4d_partition
       source: community/modules/compute/schedmd-slurm-gcp-v6-partition
       use: [h4d_nodeset]
       settings:
         partition_name: h4d

     # 5. Login + controller
     - id: slurm_login
       source: community/modules/scheduler/schedmd-slurm-gcp-v6-login
       use: [network]
       settings:
         machine_type: n2-standard-2

     - id: slurm_controller
       source: community/modules/scheduler/schedmd-slurm-gcp-v6-controller
       use:
       - network
       - homefs
       - compute_partition
       - h4d_partition
       - slurm_login
       settings:
         machine_type: c2-standard-4


================================================================================
2. Deploy the Cluster
================================================================================

From the directory containing ``gchp-cluster.yaml``:

.. code-block:: bash

   ~/cluster-toolkit/gcluster create gchp-cluster.yaml
   cd gchpslurm/primary
   terraform init
   terraform apply           # ~10-15 minutes

When ``terraform apply`` finishes you will see output similar to:

.. code-block:: text

   Apply complete! Resources: 47 added, 0 changed, 0 destroyed.

   Outputs:
   instructions_homefs = "..."
   instructions_slurm_login = "..."

Find the login node's external IP:

.. code-block:: bash

   gcloud compute instances list --filter="name~login" \
       --format="table(name,zone,networkInterfaces[0].accessConfigs[0].natIP)"

SSH in for the first time:

.. code-block:: bash

   gcloud compute ssh gchpslurm-slurm-login-001 --zone=us-central1-a

Once logged in, confirm Slurm can see the partitions:

.. code-block:: bash

   $ sinfo
   PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
   compute*  up    infinite     10    idle~ gchpslurm-compute-[0-9]
   h4d       up    infinite      4    idle~ gchpslurm-h4d-[0-3]

The ``idle~`` state means the nodes are **powered down** (cloud
burst). Slurm will boot them on demand when you ``sbatch`` a job.


================================================================================
3. Set up Falcon RDMA Networking (multi-node MPI)
================================================================================

Multi-node MPI between H4D nodes requires a second NIC on a special
:ref:`Falcon RDMA <term-falcon-rdma>` VPC subnet. This is a one-time
per-project setup.

.. code-block:: bash

   # Falcon profiles are zone-pinned; pick the zone matching your H4D partition
   ZONE=us-central1-a

   gcloud compute networks create gchp-falcon-net \
       --subnet-mode=custom \
       --bgp-routing-mode=regional \
       --network-profile=${ZONE}-vpc-falcon

   gcloud compute networks subnets create gchp-falcon-subnet \
       --network=gchp-falcon-net \
       --range=10.20.0.0/24 \
       --region=us-central1

Then attach the second NIC to your H4D nodeset by editing the
``h4d_nodeset`` block in the blueprint:

.. code-block:: yaml

   - id: h4d_nodeset
     source: community/modules/compute/schedmd-slurm-gcp-v6-nodeset
     use: [network]
     settings:
       node_count_dynamic_max: 4
       machine_type: h4d-standard-192
       bandwidth_tier: tier_1_enabled
       instance_image:
         family: gchp1470-full
         project: eece-acag
       maintenance_policy: TERMINATE
       additional_networks:
         - network: gchp-falcon-net
           subnetwork: gchp-falcon-subnet
           nic_type: IRDMA
           access_config: []                    # no external IP on RDMA NIC
       resource_policies:
         - compact-placement-policy

Re-apply:

.. code-block:: bash

   cd ~/cluster-toolkit/gchpslurm/primary
   terraform apply

The next bursted H4D node will have both gVNIC (eth0) and IRDMA
(rdma0) NICs. The ``gchp1470-full`` image already loads the
``idpf`` and ``irdma`` kernel modules at boot, so no further
configuration is required.

.. note::
   Falcon RDMA zones are limited: ``asia-southeast1-a``,
   ``europe-west4-b``, ``us-central1-a``, ``us-central1-b``, and
   ``us-west4-a``. List current availability with:

   .. code-block:: bash

      gcloud compute network-profiles list | grep falcon


================================================================================
4. Verify the GCHP image and Falcon RDMA
================================================================================

Submit a one-node interactive job on the H4D partition:

.. code-block:: bash

   srun -p h4d -N 1 -n 1 --pty bash

Once inside the compute node, confirm everything works:

.. code-block:: bash

   $ rpm -q libmd rdma-core-devel
   libmd-1.2.0-1.el8.x86_64
   rdma-core-devel-48.0-10.el8_10_ciq.x86_64

   $ lsmod | grep -E "irdma|idpf"
   irdma                 528384  0
   idpf                  188416  0

   $ ibv_devinfo | head -5
   hca_id: irdma0
       transport:    InfiniBand (0)
       state:        PORT_ACTIVE (4)            # <- Falcon RDMA ready

   $ mount | grep shared
   10.x.x.x:/nfsshare on /shared type nfs (...) # Filestore mount

If ``ibv_devinfo`` returns ``Failed to open device``, the iRDMA
provider swap (see :ref:`falcon-rdma-image`) was not applied. The
published ``gchp1470-full`` image handles this for you; if you
built your own image, see that page.


================================================================================
5. Build GCHP on the cluster
================================================================================

The compute image ships the full MPI and library stack under
``/opt/gchp``, so you do not need to install Spack, UCX, OpenMPI,
HDF5, netCDF, or ESMF yourself. What you do need to build is the
GCHP binary itself, configured for your meteorology and chemistry
choices.

Grab an H4D node interactively:

.. code-block:: bash

   srun -p h4d -N 1 -n 1 --pty bash

then bring the stack onto PATH and build GCHP into a fresh rundir.
The example below uses GCHP 14.7.0 with fullchem; substitute the
configuration appropriate to your work:

.. code-block:: bash

   source /opt/gchp/env.sh

   # Source tree (one time per cluster)
   cd /shared
   git clone --recurse-submodules https://github.com/geoschem/GCHP
   cd GCHP && git checkout 14.7.0

   # Rundir
   cd /shared/GCHP/run
   ./createRunDir.sh                       # follow the prompts

   # Build
   cd /shared/rundir-<your-name>
   mkdir -p build && cd build
   cmake -DRUNDIR=.. \
         -DCMAKE_C_COMPILER=mpicc \
         -DCMAKE_CXX_COMPILER=mpicxx \
         -DCMAKE_Fortran_COMPILER=mpifort \
         /shared/GCHP
   make -j 30 && make install

The ``gchp`` binary appears at the top of the rundir, ready for
``sbatch``. Confirm it picked up the right libraries:

.. code-block:: bash

   ldd ../gchp | grep -E "openmpi|esmf|netcdf|hdf5"
   # all paths under /opt/gchp/spack/opt/spack/linux-zen4/...


================================================================================
6. Running GCHP on the cluster
================================================================================

Save the following as ``run-gchp.sh`` in your rundir. It is the
multi-node template that uses Falcon RDMA. The ``/opt/gchp/env.sh``
sourcing replaces all the per-library Spack loads you would normally
need.

.. code-block:: bash

   #!/bin/bash
   #SBATCH --job-name=gchp-c90
   #SBATCH --partition=h4d
   #SBATCH --nodes=2
   #SBATCH --ntasks-per-node=180
   #SBATCH --time=04:00:00
   #SBATCH --chdir=/shared/rundir-c90-360

   source /opt/gchp/env.sh

   # /opt/gchp/env.sh already sets OMPI_MCA_pml, UCX_TLS, etc.
   # Override per-job if you want, for example to disable RDMA:
   # export UCX_TLS=self,sm,sysv,posix,tcp

   echo "20190701 000000" > cap_restart
   source setCommonRunSettings.sh
   source setRestartLink.sh
   source checkRunSettings.sh

   srun --mpi=pmi2 -n 360 ./gchp > h4d.20190701_0000z.log 2>&1

Submit and monitor:

.. code-block:: bash

   $ sbatch run-gchp.sh
   Submitted batch job 1

   $ squeue
   JOBID PARTITION  NAME    USER ST TIME NODES NODELIST(REASON)
      1  h4d       gchp-c90 you  CF 0:05    2  gchpslurm-h4d-[0-1] (Powering up)

   $ tail -f h4d.20190701_0000z.log
   ... GCHP Date: 2019/07/01  Time: 00:10:00  Throughput(days/day) ...


================================================================================
7. Cost Management
================================================================================

.. important::
   Cost is the most common source of surprise on GCP. Develop a
   habit of stopping compute nodes whenever you walk away from the
   cluster.


Daily idle baseline
--------------------------------------------------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 38 14 48

   * - Resource
     - Daily
     - Stoppable?
   * - Filestore 1 TB BASIC_HDD
     - $6.67
     - Only by deleting (loses ``/shared``)
   * - Controller VM
     - $5.03
     - Yes - but breaks Slurm scheduling
   * - Login VM
     - $2.33
     - Yes - but blocks SSH-in
   * - Disks + IPs
     - $2.50
     - No
   * - **Idle total**
     - **$18-20/day**
     -


Stop the cluster when you are done for the day
--------------------------------------------------------------------------------

.. code-block:: bash

   # H4D nodes auto-stop when Slurm jobs finish (~5 min idle)
   # To stop the always-on VMs (cluster won't accept new jobs until you start them):
   gcloud compute instances stop gchpslurm-controller gchpslurm-slurm-login-001 \
       --zone=us-central1-a

This drops the cost to approximately **$10/day** (Filestore + disks
only).


Watch your spend
--------------------------------------------------------------------------------

Enable **Billing export to BigQuery** in the Cloud Console
(*Billing -> Billing export*). After 24 hours you can query exact
daily spend per SKU:

.. code-block:: sql

   SELECT service.description, sku.description, SUM(cost) AS usd
   FROM `<project>.billing.gcp_billing_export_*`
   WHERE invoice.month = FORMAT_DATE('%Y%m', CURRENT_DATE())
   GROUP BY 1, 2
   ORDER BY usd DESC
   LIMIT 20


Tear down completely
--------------------------------------------------------------------------------

To stop **all** ongoing charges (including disks and Filestore):

.. code-block:: bash

   cd ~/cluster-toolkit/gchpslurm/primary
   terraform destroy             # deletes everything - files in /shared are lost

.. warning::
   ``terraform destroy`` permanently deletes the Filestore volume
   and all data in ``/shared``. Back up your GCHP build, restarts,
   and output to Cloud Storage first:

   .. code-block:: bash

      gsutil -m rsync -r /shared/rundir-c90-360/OutputDir/ \
          gs://<your-bucket>/c90-360/


================================================================================
What is next
================================================================================

* For the engineering details of the published GCHP image and how
  to build your own, see :ref:`falcon-rdma-image`.

* For terminology and pricing references, see
  :ref:`gcp-terminology`.
