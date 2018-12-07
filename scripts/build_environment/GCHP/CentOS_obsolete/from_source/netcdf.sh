# https://www.unidata.ucar.edu/software/netcdf/docs/getting_and_building_netcdf.html

export installDir=/usr
export ZDIR=$installDir
export H5DIR=$installDir
export NCDIR=$installDir
export NFDIR=$installDir

export DIR=/opt/rh/devtoolset-7/root/usr/bin
export CC=$DIR/gcc
export CXX=$DIR/g++
export F77=$DIR/gfortran
export FC=$DIR/gfortran

mkdir ~/temp_install
cd ~/temp_install

# == zlib ==
wget https://zlib.net/zlib-1.2.11.tar.gz
tar -xzf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix=${ZDIR}
make -j4
# make check
sudo make install

cd ..

# == HDF5 ==
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.2/src/hdf5-1.10.2.tar.gz
tar -xzf hdf5-1.10.2.tar.gz 
cd hdf5-1.10.2
./configure --with-zlib=${ZDIR} --prefix=${H5DIR}
make -j4
# make check
sudo make install

cd ..

# == NetCDF-C ==
wget https://github.com/Unidata/netcdf-c/archive/v4.6.1.tar.gz
tar -xzf v4.6.1.tar.gz
cd netcdf-c-4.6.1
# don't need remote access
CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=${NCDIR} --disable-dap
make -j4
# make check
sudo make install

cd ..

# == NetCDF-Fortran ==
export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
wget https://github.com/Unidata/netcdf-fortran/archive/v4.4.4.tar.gz
tar -xzf v4.4.4.tar.gz
cd netcdf-fortran-4.4.4
CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib ./configure --prefix=${NFDIR}
make -j4
# make check
sudo make install

