#!/bin/bash

GC_VERSION=12.1.1
UT_VERSION=12.1.1

# Subsequent shell commands like `sed` are only tested with version 12.1.0
# If the configure steps are changed in future versions, need to fix those shell commands

# Input data path as required by UT
# Need to pull real data later
mkdir -p ~/ExtData/HEMCO

# Create tutorial folder for demo project
mkdir ~/tutorial
cd ~/tutorial

# Source code
git clone https://github.com/geoschem/geos-chem Code.GC-classic
cd Code.GC-classic
git checkout $GC_VERSION
cd ..

# Unit Tester to create run directory
git clone https://github.com/geoschem/geos-chem-unittest.git UT
cd UT
git checkout $UT_VERSION

# Configure UT

# Each sed command change one line in a text file
# This could be trivially done by text editors by we want full automation
# Use '#' as delimiter so the line can contain '/' and ':'
# Use .* to match the rest of the line

sed -i -e "s#CODE_DIR    :=.*#CODE_DIR    :=$(HOME)/tutorial/Code.GC-classic#" runs/shared_inputs/Makefiles/Makefile

cd perl
sed -i -e 's#GCGRID_ROOT    :.*#GCGRID_ROOT    : /home/ubuntu#' CopyRunDirs.input
sed -i -e 's#DATA_ROOT      :.*#DATA_ROOT      : {GCGRIDROOT}/ExtData#' CopyRunDirs.input
sed -i -e 's#UNIT_TEST_ROOT :.*#UNIT_TEST_ROOT : {HOME}/tutorial/UT#' CopyRunDirs.input
sed -i -e 's#COPY_PATH      :.*#COPY_PATH      : {HOME}/tutorial#' CopyRunDirs.input

# show the modifications
git add -A
git status -v

# create run directory
./gcCopyRunDirs

# compile executable
cd ~/tutorial/geosfp_4x5_standard
mkdir OutputDir  # to host output data
make -j4 mpbuild NC_DIAG=y BPCH_DIAG=n TIMERS=1

# modify run-time configurations

# correctly link restart file
ln -sf $HOME/ExtData/GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.4x5_standard.nc  GEOSChem.Restart.20160701_0000z.nc4

# Use short simulation period for tutorial purpose
sed -i -e 's#End   YYYYMMDD.*#End   YYYYMMDD, hhmmss  : 20160701 002000#' input.geos

# reduce output size for tutorial purpose
sed -i -e 's#EXPID:  ./GEOSChem.*#EXPID: ./OutputDir/GEOSChem#' HISTORY.rc
sed -i -e "s/#'SpeciesConc',/'SpeciesConc',/" HISTORY.rc # make sure this collection is uncommented
sed -i -e 's#SpeciesConc.frequency.*#SpeciesConc.frequency:      00000000 002000#' HISTORY.rc
sed -i -e 's#SpeciesConc.duration.*#SpeciesConc.duration:       00000000 002000#' HISTORY.rc
sed -i -e "s#SpeciesConc.mode.*#SpeciesConc.mode:           'instantaneous'#" HISTORY.rc
sed -i -e "s#SpeciesConc.fields.*#SpeciesConc.fields:         'SpeciesConc_NO             ', 'GIGCchem',\n                              'SpeciesConc_CO             ', 'GIGCchem',\n                              'SpeciesConc_O3             ', 'GIGCchem',#" HISTORY.rc

# Run model, need to have input data.
# ./geos.mp