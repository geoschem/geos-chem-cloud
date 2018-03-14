Set up GEOS-Chem environment
============================

GEOS-Chem-classic only uses OpenMP parallelization so there is no need for MPI libraries. Having Fortran compiler and NetCDF library installed is sufficient for GC-classic to compile and run.

Environment variables
---------------------

Just follow `our wiki <http://wiki.seas.harvard.edu/geos-chem/index.php/Setting_Unix_environment_variables_for_GEOS-Chem>`_. The bashrc used for the tutorial AMI is `available for reference <https://github.com/JiaweiZhuang/cloud_GC/blob/master/build_scripts/bashrc/GEOSChem_env>`_.

Source code, run directory and input data
-----------------------------------------

Again, just follow the `wiki <http://wiki.seas.harvard.edu/geos-chem/index.php/Downloading_GEOS-Chem_source_code_and_data>`_. 

Since all data are now :ref:`available on S3 <gcdata-bucket-label>`, no need to pull them from other places.