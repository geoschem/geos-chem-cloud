#!/bin/bash
# Tested on ubuntu 18.04 LTS (ami-0ac019f4fcb7cb7e6)

# =========================
# Additional fixes for GCHP
# =========================
sudo apt-get update

# All libraries need for GCHP. f2py and mpich are new libraries in addition to GC-classic.
sudo apt-get install -y bc gcc gfortran \
    libnetcdf-dev libnetcdff-dev netcdf-bin \
    python-numpy libopenmpi-dev

# Ubuntu AMI has vim and nano but no emacs
sudo apt-get install -y emacs

# Pull S3 data without installing anaconda Python
sudo apt-get install -y awscli

# clean up cache
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

# =========================
# Additional fixes for GCHP
# =========================

# GCHP directly uses `gmake` command, which is not available on ubuntu
# https://ubuntuforums.org/showthread.php?t=1811030
sudo ln -s /usr/bin/make /usr/bin/gmake