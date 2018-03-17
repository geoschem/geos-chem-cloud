#!/bin/bash
# Tested on EC2 ubuntu-xenial-16.04 (ami-80861296)
sudo apt-get update

# The quickest way to install NetCDF libraries. Can compile GEOS-Chem classic.
sudo apt-get install -y \
    bc gcc gfortran \
    libnetcdf-dev libnetcdff-dev netcdf-bin

# Ubuntu AMI has vim and nano but no emacs
sudo apt-get install -y emacs