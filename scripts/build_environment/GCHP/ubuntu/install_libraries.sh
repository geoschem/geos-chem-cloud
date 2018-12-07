#!/bin/bash
# Tested on ubuntu 18.04 LTS (ami-0ac019f4fcb7cb7e6)
sudo apt-get update

# The quickest way to install NetCDF libraries. Can compile GEOS-Chem classic.
sudo apt-get install -y bc gcc gfortran \
    libnetcdf-dev libnetcdff-dev netcdf-bin \
    python-numpy mpich

sudo ln -s /usr/include/mpich/* /usr/include/ # so that MAPL can find header files

# GCHP directly uses `gmake` command, which is not available on ubuntu
# https://ubuntuforums.org/showthread.php?t=1811030
sudo ln -s /usr/bin/make /usr/bin/gmake

# hemco_standalone.x and geos both links -lmpichf9 which doesn't exist.
sudo ln -s /usr/lib/mpich/lib/libmpichfort.so /usr/lib/mpich/lib/libmpichf90.so
sudo ln -s /usr/lib/mpich/lib/libmpichfort.a /usr/lib/mpich/lib/libmpichf90.a