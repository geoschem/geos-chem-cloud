#!/bin/bash

GC_VERSION=b544322  # fix HEMCO dependency issue in 12.1.0
GCHP_VERSION=12.1.0

# Input data directory, need to pull real data later
mkdir -p $HOME/ExtData/HEMCO

# Create tutorial folder for demo project
mkdir ~/tutorial
cd ~/tutorial

# Source code
git clone https://github.com/geoschem/geos-chem.git Code.GCHP
cd Code.GCHP
git checkout $GC_VERSION

# Temporary fix for https://github.com/geoschem/gchp/issues/5
# Might not needed for future versions.
sed -i -e '/@$(MAKE) exe/d' HEMCO/Makefile

# GCHP subdirectory
git clone https://github.com/geoschem/gchp.git GCHP
cd GCHP
git checkout $GCHP_VERSION

# generate run directory
cd Run
rm ${HOME}/.geoschem/config
printf "$HOME/ExtData \n 2 \n 1 \n $HOME/tutorial \n gchp_standard \n n" | ./createRunDir.sh

# compile source code
cd ~/tutorial/gchp_standard
ln -s ~/gchp.ubuntu.env gchp.env  # need to copy gchp.ubuntu.env to $HOME
make compile_clean


# modify run-time configurations

# correctly link restart file
ln -sf $HOME/ExtData/GEOSCHEM_RESTARTS/v2016-07/initial_GEOSChem_rst.c24_standard.nc  initial_GEOSChem_rst.c24_standard.nc

# read low-resolution metfields to save space
ln -sf $HOME/ExtData/GEOS_4x5/GEOS_FP MetDir 
sed -i -e 1,120s/025x03125.nc/4x5.nc/g ExtData.rc # only scan the first few lines, do not modify non-metfields

# hard to see why simulation crashes with default debug level 0
# sed -i -e "s#DEBUG_LEVEL.*#DEBUG_LEVEL: 5#" CAP.rc

# Turn off CEDS as GCHP 12.1.0 still reads the old, large file.
sed -i -e "s#.--> CEDS.*# --> CEDS                   :       false#" HEMCO_Config.rc
sed -i -e "s#.--> CEDS_SHIP.*# --> CEDS                   :       false#" HEMCO_Config.rc

# Run model, need to have input data.
# mpirun -np 6 ./geos