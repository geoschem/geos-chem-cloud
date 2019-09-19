#!/bin/bash
# Tested on ubuntu 18.04 LTS (ami-0ac019f4fcb7cb7e6)

# This is a subset of GCHP dependencies.
# Now we use the same AMI for classic and HP, so no need to run this script.

sudo apt-get update

# All libraries need for GEOS-Chem classic.
sudo apt-get install -y \
    gc gcc gfortran \
    libnetcdf-dev libnetcdff-dev netcdf-bin

# additional utils
sudo apt-get install -y emacs git-gui gitk awscli

# clean up cache
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
