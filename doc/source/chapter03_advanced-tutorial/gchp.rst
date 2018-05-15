GEOS-Chem High-Performance version (GCHP) (experimental)
========================================================

We've successfully made GCHP running on the cloud. **It is functioning correctly** but there are several issues to be resolved:

- GCHP compiles with gfortran, but the overall performance is ~20% slower than with ifort. The major slow down comes from the new advection module (GFDL-FV3).
- The initial I/O takes a long time (does not affect long-term simulations).
- The data analysis pipeline is not fully documented. We do have some `preliminary scripts <http://ftp.as.harvard.edu/pub/exchange/elundgren/CSCI29/ipynb/>`_ to process and regrid cubed-sphere data, though.
- It is only set up to run in a single node, with at most 72 CPUs (c5.18xlarge).

Right now it is pretty good for learning and for small experiments. We will make a major update after the formal release of v11-02.

GCHP inside Singularity container
---------------------------------

We will be using :doc:`containers <./container>` to run GCHP. It allows you to set up GCHP quickly on almost **any machines**, not just on Amazon cloud. You can adapt this guide for your own server.

The Singularity image for GCHP can be obtained from `Singularity Hub <https://singularity-hub.org/collections/946/usage>`_, with the command::

  $ singularity pull --name GCHP.simg shub://JiaweiZhuang/Singularity_GC

Launch server
-------------

Launch from the AMI ID ``ami-21f37a5e``. This AMI is just to provide sample input data and pre-configured run directory. The software libraries will be provided by Singularity container.

The minimum `hardware requirement <http://wiki.seas.harvard.edu/geos-chem/index.php/GCHP_Hardware_and_Software_Requirements>`_ is ``r4.2xlarge`` with 8 CPUs and 60 GB memory. The minimum number of MPI processes for GCHP is 6 (one for each cubed-sphere panel). You can still start a GCHP simulation on an instance with <6 CPUs, but the program is likely to die somewhere.

Test run
--------

After launching the instance and logging-in (username is ``ubuntu``), you should see::

  $ ls
  gcdata  GCHP  GCHP.simg  miniconda  singularity

Run the container interactively by::

  $ singularity shell GCHP.simg

If you just execute the container by ``./GCHP.simg``, it will print some instructions.

Go to the run directory and execute the pre-compiled executable::

  $ cd ~/GCHP/gchp_standard
  $ mpirun -np 6 ./geos

Test compile
------------

To re-compile the model, for now you need to specify the code directory when starting the container::

  $ SINGULARITYENV_GC_CODE_DIR=~/GCHP/Code.v11-02_gchp singularity shell GCHP.simg

Then re-compile the model in the run directory::

  $ cd ~/GCHP/gchp_standard
  $ make compile_clean

For more information please see `the official tutorial on GCHP wiki <http://wiki.seas.harvard.edu/geos-chem/index.php/Getting_Started_With_GCHP>`_.