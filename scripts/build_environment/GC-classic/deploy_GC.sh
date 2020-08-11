#!/bin/bash

#==============================================================================
# deploy_GC.sh:
#
# Script to create the tutorial folder (except for the
# python example)
#==============================================================================

#==============================================================================
# Create folders
#==============================================================================

# Input data path as required by UT
# Need to pull real data later
rm -rf ExtData
mkdir -p ~/ExtData

# Create tutorial folder for demo project
if [[ ! -d ~/tutorial ]]; then
    mkdir ~/tutorial
fi
cd ~/tutorial

#=============================================================================
# Git clone
#=============================================================================

# Source code
git clone -b master https://github.com/geoschem/geos-chem Code.GC-classic

# Unit Tester to create run directory
git clone -b master https://github.com/geoschem/geos-chem-unittest.git UT


#=============================================================================
# Configure UT
#=============================================================================

# Change to UT/perl directory
cd UT/perl

# Each sed command change one line in a text file
# This could be trivially done by text editors by we want full automation
# Use '#' as delimiter so the line can contain '/' and ':'
# Use .* to match the rest of the line
sed -i -e 's#CODE_DIR       :.*#CODE_DIR       : /home/ubuntu/tutorial/Code.GC-classic#' CopyRunDirs.input
sed -i -e 's#GCGRID_ROOT    :.*#GCGRID_ROOT    : /home/ubuntu#' CopyRunDirs.input
sed -i -e 's#DATA_ROOT      :.*#DATA_ROOT      : /home/ubuntu/ExtData#' CopyRunDirs.input
sed -i -e 's#UNIT_TEST_ROOT :.*#UNIT_TEST_ROOT : /home/ubuntu/tutorial/UT#' CopyRunDirs.input
sed -i -e 's#RUN_ROOT       :.*#RUN_ROOT       : /home/ubuntu/tutorial/UT/runs#' CopyRunDirs.input
sed -i -e 's#PERL_ROOT      :.*#PERL_ROOT      : /home/ubuntu/tutorial/UT/perl#' CopyRunDirs.input
sed -i -e 's#COPY_PATH      :.*#COPY_PATH      : /home/ubuntu/tutorial#' CopyRunDirs.input

# show the modifications
git add -A
git status -v

# create run directory
./gcCopyRunDirs

#==============================================================================
# Modify run-time configurations
#==============================================================================

# Change to run dir
cd ~/tutorial/geosfp_4x5_standard

# Edit input.geos: Use short simulation period for tutorial
sed -i -e 's#End   YYYYMMDD.*#End   YYYYMMDD, hhmmss  : 20160701 002000#' input.geos

# Edit HISTORY.rc: Reduce output size for tutorial
sed -i -e "s/#'SpeciesConc',/'SpeciesConc',/" HISTORY.rc # make sure this collection is uncommented
sed -i -e 's#SpeciesConc.frequency.*#SpeciesConc.frequency:      00000000 002000#' HISTORY.rc
sed -i -e 's#SpeciesConc.duration.*#SpeciesConc.duration:       00000000 002000#' HISTORY.rc
sed -i -e "s#SpeciesConc.mode.*#SpeciesConc.mode:           'instantaneous'#" HISTORY.rc
sed -i -e "s#SpeciesConc.fields.*#SpeciesConc.fields:         'SpeciesConc_NO             ', 'GIGCchem',\n                              'SpeciesConc_CO             ', 'GIGCchem',\n                              'SpeciesConc_O3             ', 'GIGCchem',#" HISTORY.rc

#==============================================================================
# Compile executable
#==============================================================================

# NOTE: Need to update to Cmake in future
mkdir gcbuild
cd gcbuild
cmake ../CodeDir
make -j install
if [[ $? != 0 ]]; then
    echo "Compilation failed...exiting!"
    exit
fi

cd ..

# Do a dry-run simulation to get input data
./geos --dryrun > log.dryrun
if [[ $? != 0 ]]; then
    echo "Dry-run failed...exiting!"
    exit
fi

# Download the basic data for the tutorial
./download_data.py log.dryrun -aws
if [[ $? != 0 ]]; then
    echo "Data download failed...exiting!"
    exit
fi

# Run model, need to have input data.
./geos
