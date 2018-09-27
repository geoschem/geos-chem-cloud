List of public AWS resources for GEOS-Chem
==========================================

Currently all resources are in us-east-1 (N. Virginia).

Latest resources:
+-------------------+------------------------+----------+----------------------------------+
| Resource          | ID/name                | Size     | Content                          |
+===================+========================+==========+==================================+
|| Tutorial AMI     | ami-08c83a8b3ebd20b63  | 100 GB   |                                  |
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
|| GCHP             | ami-21f37a5e           | 100 GB   | 1. Pre-configured GCHP rundir    |
|| experimental     |                        |          | 2. Sample GCHP input data        |
|| AMI              |                        |          | 3. GCHP container environment    |
+-------------------+------------------------+----------+----------------------------------+
|| S3 bucket for    | s3://gcgrid            | ~30 TB   | All current GEOS-Chem input data |
|| all GC data      | (requester-pay)        |          |                                  |
+-------------------+------------------------+----------+----------------------------------+

Historical resources (for record):
+-------------------+------------------------+----------+----------------------------------+
| Resource          | ID/name                | Size     | Content                          |
+===================+========================+==========+==================================+
|| Older tutorial   | ami-ab925cd6           | 70 GB    | Same as tutorial AMI             |
|| AMI              |                        |          | but uses v11-02d                 |
+-------------------+------------------------+----------+----------------------------------+