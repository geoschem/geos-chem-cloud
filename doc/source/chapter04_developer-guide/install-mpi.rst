Install MPI libraries
=====================

GCHP would need MPI library. Most of other models would need MPI, too.

Enabling in-node MPI parallelization is pretty trivial since no network configurations are required. For cross-node MPI run, using the pre-built MPI library provided by :ref:`HPC cluster management tools <hpc-overview-label>` would be much easier.

More details coming soon... The `Dockerfile for WRF <https://github.com/NCAR/container-wrf/blob/master/3.7.1/ncar-wrf/Dockerfile>`_ is a good reference for installing MPI libraries using the package manager. They use CentOS as the base OS.