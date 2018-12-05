#!/bin/bash

GC_VERSION=12.1.0
GCHP_VERSION=12.1.0

# Input data directory, need to pull real data later
mkdir -p ~/ExtData/HEMCO

# Create tutorial folder for demo project
mkdir ~/tutorial
cd ~/tutorial

# Source code
git clone https://github.com/geoschem/geos-chem.git Code.GCHP
cd Code.GCHP
git checkout -b $GC_VERSION

# GCHP subdirectory
git clone https://github.com/geoschem/gchp.git GCHP
cd GCHP
git checkout -b $GCHP_VERSION

cd Run
rm ${HOME}/.geoschem/config
echo "$HOME/ExtData
2
1
$HOME/tutorial
gchp_standard
n" | ./createRunDir.sh

cd ~/tutorial/gchp_standard

ln -sf /home/ec2-user/ExtData/GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.c24_standard.nc  initial_GEOSChem_rst.c24_standard.nc 

# read low-resolution metfields to save space
ln -sf /home/ec2-user/ExtData/GEOS_4x5/GEOS_FP MetDir

# only scan the first few lines, do not modify non-metfields
sed -i -e 1,120s/025x03125.nc/4x5.nc/g ExtData.rc

# hard to see why simulation crashes with default debug level 0
sed -i -e "s#DEBUG_LEVEL.*#DEBUG_LEVEL: 5#" CAP.rc

# Turn off CEDS as GCHP 12.1.0 still reads the old, large file.
sed -i -e "s#.--> CEDS.*# --> CEDS                   :       false#" HEMCO_Config.rc
sed -i -e "s#.--> CEDS_SHIP.*# --> CEDS                   :       false#" HEMCO_Config.rc
