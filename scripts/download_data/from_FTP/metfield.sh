#!/bin/bash

# based on
# http://wiki.seas.harvard.edu/geos-chem/index.php/Downloading_GEOS-Chem_source_code_and_data#Directories_for_met_fields_and_emissions_data

# Assume that parent dir is already created
cd /home/ubuntu/gcdata/ExtData/

# GEOSFP 4x5 CN field
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/ExtData/GEOS_4x5/GEOS_FP/2011/01/"

# GEOSFP 4x5 1-month
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/ExtData/GEOS_4x5/GEOS_FP/2016/07/"
