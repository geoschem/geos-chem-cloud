# Script to download GEOS-Chem input data from S3

- Get minimal necessary input data for GC-classic: all_input_GC-classic.sh
- Get minimal necessary input data for GCHP: all_input_GCHP.sh

AWSCLI must be installed & configured.

After a new version release, might need to add & remove entries in each script (especially HEMCO.sh). Consider a more structured script in the long term. For example, maintaining a textfile of all necessary subdirectories, and parse that file into AWSCLI arguments.
