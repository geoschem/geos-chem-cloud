List of public AWS resources for GEOS-Chem 
==========================================

Currently all resources are in us-east-1 (N. Virginia).

+-------------------+------------------------+----------+----------------------------------+
| Resource          | ID/name                | Size     | Content                          |
+===================+========================+==========+==================================+
|| Tutorial AMI     | ami-0b851a1d           | 90 GB    | Core AMI + sample data below     |
|                   |                        |          |                                  |
+-------------------+------------------------+----------+----------------------------------+
|| Core AMI         | ami-d4e817a9           | 8 GB     | 1. gcc & gfortran 5.4.0,         | 
|                   |                        |          |    netCDF-Fortran 4.4.3          |
|                   |                        |          | 2. GC environment variables      |
|                   |                        |          | 3. GC source code and Unit Tester|
|                   |                        |          | 4. 4x5 geosfp run directory      |
|                   |                        |          | 5. Pre-compiled executable       |
|                   |                        |          |    in rundir                     |
|                   |                        |          | 6. Geoscientific Python          |
|                   |                        |          |    environment                   |
|                   |                        |          | 7. Empty gcdata directory        |
+-------------------+------------------------+----------+----------------------------------+
|| EBS snapshot     | snap-07fa87b42f0983f49 | 80 GB    | 1. HEMCO data for v11-02         |
|| for sample data  |                        |          | 2. 1-month GEOS-FP 4x5 data      |
+-------------------+------------------------+----------+----------------------------------+
|| S3 bucket for    | s3://gcgrid            | ~30 TB   | All current GEOS-Chem input data |
|| all GC data      | (requester-pay)        |          |                                  |
+-------------------+------------------------+----------+----------------------------------+
