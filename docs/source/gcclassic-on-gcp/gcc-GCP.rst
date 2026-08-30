.. |br| raw:: html

   <br />

.. _run-gcc-on-gcp:

#####################################
Run GEOS-Chem Classic on Google Cloud
#####################################

`GEOS-Chem Classic <https://geos-chem.readthedocs.io>`__ is an `OpenMP
<https://www.openmp.org/>`__ application, meaning it runs on a **single
node**. Unlike :ref:`GCHP on Google Cloud <prepare-gcp-environment>`,
you do **not** need a Slurm cluster, MPI, or Falcon RDMA. You simply
launch **one** Compute Engine VM, build the model, and run it with
OpenMP threads.

================================================================================
Choose a machine type
================================================================================

GEOS-Chem Classic uses OpenMP threads within a single VM, so choose a
**compute-optimized** instance with enough vCPUs and memory for your
resolution. A few good options:

.. list-table:: Suggested single-node instance types
   :align: center
   :header-rows: 1
   :widths: 26 12 12 16 34

   * - Machine type
     - vCPUs
     - Cores
     - Memory (GB)
     - Notes
   * - ``c2-standard-30``
     - 30
     - 15
     - 120
     - Intel; fine for 4x5 / nested simulations
   * - ``c2-standard-60``
     - 60
     - 30
     - 240
     - Intel; higher resolutions
   * - ``c3d-standard-60``
     - 60
     - 30
     - 240
     - AMD Zen4; boots the published image directly (Option A below)
   * - ``h4d-standard-192``
     - 192
     - 192
     - ~720
     - AMD Zen4; more than Classic needs, but boots the image directly

.. tip::

   To save money, launch the VM as a **Spot VM**
   (add ``--provisioning-model=SPOT`` to the ``gcloud`` command).
   Classic runs are usually short enough to finish before a Spot VM is
   reclaimed.

================================================================================
Set up the software environment
================================================================================

GEOS-Chem Classic needs a Fortran compiler, netCDF-C, netCDF-Fortran,
and CMake. There are two ways to get them on Google Cloud.

**Option A — reuse the published compute image (fastest).**
The :ref:`GCHP compute image <falcon-rdma-image>` (``gchp1470-full``,
hosted in project ``eece-acag``) already ships the full library stack
under ``/opt/gchp`` — a superset of what Classic needs. Because that
image is built for **AMD Zen4**, boot it on a Zen4 machine type
(``c3d-*`` or ``h4d-standard-192``). The RDMA modules in the image are
harmless here; Classic simply does not use them.

.. code-block:: bash

   gcloud compute instances create gcclassic-node \
       --zone=us-central1-a \
       --machine-type=c3d-standard-60 \
       --image-family=gchp1470-full \
       --image-project=eece-acag \
       --boot-disk-size=50GB \
       --create-disk=name=gcc-data,size=500GB,type=pd-balanced,auto-delete=no

Then, on the VM, load the stack:

.. code-block:: bash

   source /opt/gchp/env.sh          # puts gfortran, cmake, nc-config on PATH
   which gfortran nf-config cmake

**Option B — build a minimal stack with Spack (any instance).**
If you prefer an Intel instance, a smaller VM, or a fresh build,
install `Spack <https://spack.io>`__ on your data disk and build the
Classic dependencies (a compiler, ``netcdf-c``, ``netcdf-fortran``,
and ``cmake``). See the `GEOS-Chem Classic build instructions
<https://geos-chem.readthedocs.io/en/stable/gcclassic/index.html>`__
for the exact library requirements.

.. warning::

   Keep the model, run directories, and input data on a **dedicated
   data disk** (e.g. the ``gcc-data`` disk above), **not** on the small
   boot disk.

================================================================================
Connect to your instance
================================================================================

.. code-block:: bash

   gcloud compute ssh gcclassic-node --zone=us-central1-a

(You can also SSH to the VM's external IP directly if you assigned one
and opened port 22 in your VPC firewall.)

================================================================================
Download the source code and input data
================================================================================

Follow the `GEOS-Chem Classic Quickstart Guide
<https://geos-chem.readthedocs.io/en/stable/getting-started/quick-start.html>`__
to clone the source, create a run directory, and configure your
simulation on the data disk.

GEOS-Chem input data is hosted in the public ``s3://geos-chem`` bucket.
You can pull it directly from Google Cloud (cross-cloud egress
applies), or, for repeated use, mirror the years and collections you
need into a **same-region Cloud Storage bucket** first to avoid egress
charges. The `bashdatacatalog
<https://github.com/LiamBindle/bashdatacatalog>`__ tool downloads
exactly the collections your simulation requires.

================================================================================
Build and run
================================================================================

Build GEOS-Chem Classic in your run directory as described in the
Quickstart Guide (``cmake`` + ``make -j`` + ``make install``), using
the compilers from Option A or B. This produces a ``gcclassic``
executable in the run directory.

Because Classic is OpenMP, set the thread count to the number of
**physical cores** on your VM before running:

.. code-block:: bash

   export OMP_NUM_THREADS=30        # e.g. 30 on c2-standard-60 / c3d-standard-60
   ./gcclassic | tee run.log

More threads generally means faster runs, up to the memory-bandwidth
limit of the instance.

================================================================================
Stop or delete the VM
================================================================================

Compute Engine bills while the VM is **running**. When your simulation
finishes:

.. code-block:: bash

   # Stop the VM (keeps disks so you can resume later):
   gcloud compute instances stop gcclassic-node --zone=us-central1-a

   # Or delete it entirely once you have copied off your output:
   gcloud compute instances delete gcclassic-node --zone=us-central1-a
   gcloud compute disks delete gcc-data --zone=us-central1-a

.. tip::

   A **stopped** VM still bills for its persistent disks. Once you have
   saved your output (e.g. copied it to a Cloud Storage bucket), delete
   the data disk too.
