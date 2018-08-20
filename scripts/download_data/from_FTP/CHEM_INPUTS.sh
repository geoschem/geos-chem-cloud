#!/bin/bash

# based on step 8 of
# http://wiki.seas.harvard.edu/geos-chem/index.php/Setting_up_the_ExtData_directory#Creating_the_ExtData_directory_structure

# Assume that parent dir is already created
cd /home/ubuntu/gcdata/ExtData/CHEM_INPUTS

# different from downloading HEMCO data, here only need to cut the first 3 dir components
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/GEOS_NATIVE/FastJ_201204"
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/GEOS_1x1/Linoz_200910"
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/GEOS_NATIVE/MODIS_LAI_201204"
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/GEOS_NATIVE/Olson_Land_Map_201203"
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/GEOS_NATIVE/TOMAS_201402"
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/GEOS_NATIVE/UCX_201403"

wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/ExtData/CHEM_INPUTS/MODIS_LAI_201707"
