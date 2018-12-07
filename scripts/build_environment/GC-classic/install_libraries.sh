#!/bin/bash
# Tested on EC2 ubuntu-xenial-18.04 (ami-01ac7d9c1179d7b74)
sudo apt-get update

# All libraries need for GEOS-Chem classic.
sudo apt-get install -y \
    bc gcc gfortran \
    libnetcdf-dev libnetcdff-dev netcdf-bin

# Ubuntu AMI has vim and nano but no emacs
sudo apt-get install -y emacs

# Pull S3 data without installing anaconda Python
sudo apt-get install -y awscli

# clean up cache
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*