# Script to download GEOS-Chem input data

## Contents

./from_S3 for getting data from AWS (to both EC2 or local machines)

./from_FTP contains equivalent scripts that pulls from Harvard FTP (might not be up-to-date).

## Deprecation warning

These scripts are now obsolete for GEOS_Chem 12.7.0 and later versions.  The [GEOS-Chem dry-run capability](http://wiki.geos-chem.org/Downloading_data_with_the_GEOS-Chem_dry-run_option) can now be used to generate a list of files that can be used to download data.