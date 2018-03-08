List of public AWS resources for GEOS-Chem 
==========================================

Currently all resources are in us-east-1 (N. Virginia).

+-------------------+------------------------+----------+----------------------------------+
| Resource          | ID/name                | Size     | Content                          |
+===================+========================+==========+==================================+
|| Tutorial AMI     | ami-c135ccbc           | 70 GB    |                                  |
|                   |                        |          | 1. gfortran 5.4.0,               | 
|                   |                        |          |    netCDF-Fortran 4.4.3          |
|                   |                        |          | 2. GC environment variables      |
|                   |                        |          | 3. GC source code and Unit Tester|
|                   |                        |          | 4. 4x5 geosfp run directory      |
|                   |                        |          | 5. Pre-compiled executable       |
|                   |                        |          |    in rundir                     |
|                   |                        |          | 6. Geoscientific Python          |
|                   |                        |          |    environment                   |
|                   |                        |          | 7. Sample gcdata directory       |
+-------------------+------------------------+----------+----------------------------------+
|| S3 bucket for    | s3://gcgrid            | ~30 TB   | All current GEOS-Chem input data |
|| all GC data      | (requester-pay)        |          |                                  |
+-------------------+------------------------+----------+----------------------------------+
