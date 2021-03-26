List of public AWS resources for GEOS-Chem
==========================================

Currently all resources are in us-east-1 (N. Virginia).

Latest resources:

+-------------------+------------------------+----------+-------------------------------------+
| Resource          | ID/name                | Size     | Content                             |
+===================+========================+==========+=====================================+
|| Standard tutorial| ami-0ebb738afafa614cf  | 200 GB   | 0. Ubuntu 18.04                     |
|  AMI              |                        |          | 1. gfortran 8.2.0,                  |
|                   |                        |          |    netCDF-Fortran 4.5.2             |
|                   |                        |          | 2. Geoscientific Python             |
|                   |                        |          |    environment                      |
|                   |                        |          | 3. Pre-compiled GC-classic 13.0.1   |
|                   |                        |          | 4. Minimum GEOS-Chem input data     |
|                   |                        |          |    (use a dry-run to get more data) |
+-------------------+------------------------+----------+-------------------------------------+
|| Container        | ami-040f96ea8f5a0973e  | 200 GB   | 0. Amazon Linux 2 AMI               |
|  tutorial AMI     |                        |          | 1. Docker 18.06.1-ce,               |
|                   |                        |          |    Singularity 3.0.1,               |
|                   |                        |          |    CharlieCloud 0.9.7               |
|                   |                        |          | 2. Minimum GEOS-Chem input data     |
+-------------------+------------------------+----------+-------------------------------------+
|| S3 bucket for    | s3://gcgrid            | ~30 TB   | All current GEOS-Chem input data    |
|| all GC data      | (requester-pay)        |          |                                     |
+-------------------+------------------------+----------+-------------------------------------+

Old resources (for record):

+-------------------+------------------------+----------+-------------------------------------+
| Resource          | ID/name                | Size     | Content                             |
+===================+========================+==========+=====================================+
|| 12.7.0 tutorial  | ami-03de1c3610e0e77a2  | 200 GB   | 0. Ubuntu 18.04                     |
|  AMI              |                        |          | 1. gfortran 7.3.0,                  |
|                   |                        |          |    netCDF-Fortran 4.4.4             |
|                   |                        |          | 2. Geoscientific Python             |
|                   |                        |          |    environment                      |
|                   |                        |          | 3. Pre-compiled GC-classic 12.7.0   |
|                   |                        |          | 4. Minimum GEOS-Chem input data     |
+-------------------+------------------------+----------+-------------------------------------+
|| 12.9.3 tutorial  | ami-04751feef8546fdfe  | 200 GB   | 0. Ubuntu 18.04                     |
|  AMI              |                        |          | 1. gfortran 8.2.0,                  |
|                   |                        |          |    netCDF-Fortran 4.5.2             |
|                   |                        |          | 2. Geoscientific Python             |
|                   |                        |          |    environment                      |
|                   |                        |          | 3. Pre-compiled GC-classic 12.9.3   |
|                   |                        |          | 4. Minimum GEOS-Chem input data     |
|                   |                        |          |    (use dry-run to get more data)   |
+-------------------+------------------------+----------+-------------------------------------+
|| 13.0.0-rc.0      | ami-0908204b481f1aac2  | 200 GB   | 0. Ubuntu 18.04                     |
|  tutorial AMI     |                        |          | 1. gfortran 8.2.0,                  |
|                   |                        |          |    netCDF-Fortran 4.5.2             |
|                   |                        |          | 2. Geoscientific Python             |
|                   |                        |          |    environment                      |
|                   |                        |          | 3. Pre-compiled GC-classic 13.0.0rc |
|                   |                        |          | 4. Minimum GEOS-Chem input data     |
|                   |                        |          |    (use a dry-run to get more data) |
+-------------------+------------------------+----------+-------------------------------------+
|| 13.0.0 tutorial  | ami-0ef2c8a2d3464485c  | 200 GB   | 0. Ubuntu 18.04                     |
|  AMI              |                        |          | 1. gfortran 8.2.0,                  |
|                   |                        |          |    netCDF-Fortran 4.5.2             |
|                   |                        |          | 2. Geoscientific Python             |
|                   |                        |          |    environment                      |
|                   |                        |          | 3. Pre-compiled GC-classic 13.0.0   |
|                   |                        |          | 4. Minimum GEOS-Chem input data     |
|                   |                        |          |    (use a dry-run to get more data) |