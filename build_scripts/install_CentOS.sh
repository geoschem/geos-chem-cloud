#!/bin/bash
# tested on CentOS Linux 7 (ami-b81dbfc5)

# those very basic tools are not on CentOS by default
# bzip2 is for decompressing anaconda
# remember to add emacs for production version
sudo yum install -y wget vim git tmux m4 bzip2 

sudo yum install -y epel-release # extra repo for NetCDF and MPI
sudo yum install -y libnetcdf-devel libnetcdff-devel
# The module file will be at /usr/lib64/gfortran/modules/netcdf.mod

# Add MPI library
sudo yum install -y mpich-3.0-devel # use 3.2 instead?
export PATH=$PATH:/usr/lib64/mpich/bin # not in /usr/bin, unlike Ubuntu