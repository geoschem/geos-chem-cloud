#!/bin/bash

GC_VERSION=12.1.0 
UT_VERSION=12.1.0 

# Input data path as required by UT
# Need to pull real data later
mkdir -p ~/ExtData/HEMCO

# Create tutorial folder for demo project
mkdir ~/tutorial
cd ~/tutorial

# Source code
git clone https://github.com/geoschem/geos-chem Code.$GC_VERSION
cd Code.GC
git checkout -b $GC_VERSION

# Unit Tester to create run directory
git clone https://github.com/geoschem/geos-chem-unittest.git UT
cd UT
git checkout -b $UT_VERSION

# change UT configurations
modify_line () {
# convenient function to change one line in a text file
local key=$1  # unique pattern to locate a line
local newline=$2  # newline as the replacement
local file=$3
# use '#' as delimiter so the line can contain '/' and ':'
sed -i -e "s#.*${key}.*#${newline}#" $file
}

modify_line 'CODE_DIR    :=' ' CODE_DIR    :=$(HOME)/tutorial/Code.$(VERSION)' runs/shared_inputs/Makefiles/Makefile

cd perl
modify_line 'GCGRID_ROOT    :' '   GCGRID_ROOT    : /home/ubuntu' CopyRunDirs.input
modify_line 'DATA_ROOT      :' '   DATA_ROOT      : {GCGRIDROOT}/ExtData' CopyRunDirs.input
modify_line 'UNIT_TEST_ROOT :' '   UNIT_TEST_ROOT : {HOME}/tutorial/UT' CopyRunDirs.input
modify_line 'COPY_PATH      :' '   COPY_PATH      : {HOME}/tutorial' CopyRunDirs.input

# show the modifications
git add -A
git status -v

# create run directory
./gcCopyRunDirs

# compile executable
cd ~/tutorial/geosfp_4x5_standard
make -j4 mpbuild NC_DIAG=y BPCH_DIAG=n TIMERS=1

# change run-time configuration for tutorial purpose
modify_line 'End   YYYYMMDD' 'End   YYYYMMDD, hhmmss  : 20160701 002000' input.geos

mkdir OutputDir
modify_line "EXPID:  ./GEOSChem" "EXPID: ./OutputDir/GEOSChem" HISTORY.rc
modify_line "SpeciesConc'" "             'SpeciesConc'," HISTORY.rc # make sure this collection is uncommented

# reduce output size for tutorial purpose
modify_line "SpeciesConc.frequency" "  SpeciesConc.frequency:      00000000 002000" HISTORY.rc
modify_line "SpeciesConc.duration" "  SpeciesConc.duration:       00000000 002000" HISTORY.rc
modify_line "SpeciesConc.mode" "  SpeciesConc.mode:           'instantaneous'" HISTORY.rc
modify_line "SpeciesConc.fields" "  SpeciesConc.fields:         'SpeciesConc_NO             ', 'GIGCchem',\n                              'SpeciesConc_CO             ', 'GIGCchem',\n                              'SpeciesConc_O3             ', 'GIGCchem'," HISTORY.rc