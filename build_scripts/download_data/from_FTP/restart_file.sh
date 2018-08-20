#!/bin/bash

# based on
# http://wiki.seas.harvard.edu/geos-chem/index.php/Downloading_GEOS-Chem_source_code_and_data#Directories_for_met_fields_and_emissions_data

# Assume that parent dir is already created
cd /home/ubuntu/gcdata/ExtData/

# 4x5x72L fullchem netcdf restart
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/ExtData/NC_RESTARTS/initial_GEOSChem_rst.4x5_benchmark.nc"

# this is used in timing test
wget -r -nH --cut-dirs=3 "ftp://ftp.as.harvard.edu/gcgrid/data/ExtData/SPC_RESTARTS/initial_GEOSChem_rst.4x5_standard.nc"
