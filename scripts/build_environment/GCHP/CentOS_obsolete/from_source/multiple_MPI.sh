#!/bin/bash
# Install multiple MPI implementation; can take ~20min.

# need to use absolute path, otherwise "make install" will fail at the last step
export DIR=/opt/rh/devtoolset-7/root/usr/bin
export CC=$DIR/gcc
export CXX=$DIR/g++
export F77=$DIR/gfortran
export FC=$DIR/gfortran

mkdir -p ~/temp_install
cd ~/temp_install

# == OpenMPI ==
# https://www.open-mpi.org/software/ompi/v3.0/
wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.1.tar.gz
tar zxf openmpi-3.0.1.tar.gz
cd openmpi-3.0.1
./configure prefix=/usr/local/openmpi
make -j4
sudo make install

cd ..

# == MPICH ==
# https://www.mpich.org/downloads/
wget http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
tar zxf mpich-3.2.1.tar.gz
cd mpich-3.2.1
./configure prefix=/usr/local/mpich
make -j4
sudo make install

cd ..

# == MVAPICH ==

# MVAPICH needs libibverbs and libibmad-devel by default, even if not using InfiniBand
# https://lists.sdsc.edu/pipermail/npaci-rocks-discussion/2012-October/059794.html
# http://mailman.cse.ohio-state.edu/pipermail/mvapich-discuss/2013-July/004477.html
# also need yacc at compile time
sudo yum install -y libibverbs-devel libibmad-devel byacc

# http://mvapich.cse.ohio-state.edu/downloads/
wget http://mvapich.cse.ohio-state.edu/download/mvapich/mv2/mvapich2-2.3rc1.tar.gz
tar zxf mvapich2-2.3rc1.tar.gz
cd mvapich2-2.3rc1
./configure prefix=/usr/local/mvapich
make -j4
sudo make install
