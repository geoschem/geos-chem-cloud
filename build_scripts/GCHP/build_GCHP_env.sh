#!/bin/bash

# ====================================
# --- General information ---
# ====================================

# Build GCHP environment
# Tested on CentOS 7 (ami-b81dbfc5) + gcc/gfortran 4.8.5 + mpich3.2

# Use CentOS because Ubuntu is too strictive about the order of arguments for compilers
# MAPL's Makefile is already a mess and is hard to fix on Ubuntu
# See https://stackoverflow.com/questions/13941549/compiling-fortran-netcdf-programs-on-ubuntu

# Use MPICH because the yum package manager can get the latest version (3.2).
# OpenMPI and MVAPICH lead to error "ld: cannot find -lmpi_f77" when compiling ESMF,
# but should not be hard to fix by linking lib files.

# For more about MPICH for GCHP, see  http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_HP_v11-02#MPICH_MPI_implementation_not_readily_usable_with_GCHP

# ====================================
# --- Library installation ---
# ====================================

# those very basic tools are not on CentOS by default
# bzip2 is for decompressing anaconda
# remember to add emacs for production version
sudo yum install -y wget vim git screen tmux m4 bzip2 bc

# Install GNU compiler family MAPL needs c++ compiler
sudo yum install -y gcc gcc-gfortran gcc-c++ 

# Enable extra repo for NetCDF and MPI
sudo yum install -y epel-release

# Install development tools for NetCDF-C and NetCDF-Fortran
sudo yum install -y netcdf-devel netcdf-fortran-devel
# netcdf.mod will be placed in /usr/lib64/gfortran/modules/, not in /usr/include/ as Ubuntu

# Install MPICH development tool
sudo yum install -y mpich-3.2-devel
# Executables are in /usr/lib64/mpich-3.2/bin; Header files are in /usr/include/mpich-3.2-x86_64
# Need to tweak environment variables. See the file bashrc_GCHP_CentOS

