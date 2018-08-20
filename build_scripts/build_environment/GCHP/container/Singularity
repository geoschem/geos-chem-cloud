BootStrap: docker
From: centos:centos7

%post
    # ====================
    #   Install basics
    # ====================
    yum -y update
    yum install -y make wget vim git m4 bzip2 bc numpy-f2py centos-release-scl
    yum install -y devtoolset-7-gcc-gfortran devtoolset-7-gcc-c++
    yum clean all # clean-up cache

    # ====================
    #   Install NetCDF
    # ====================

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

    cd /tmp

    # == zlib ==
    wget https://zlib.net/zlib-1.2.11.tar.gz
    tar -xzf zlib-1.2.11.tar.gz
    cd zlib-1.2.11
    ./configure --prefix=${ZDIR}
    make -j4
    make install

    cd /tmp

    # == HDF5 ==
    wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.2/src/hdf5-1.10.2.tar.gz
    tar -xzf hdf5-1.10.2.tar.gz
    cd hdf5-1.10.2
    ./configure --with-zlib=${ZDIR} --prefix=${H5DIR}
    make -j4
    make install

    cd /tmp

    # == NetCDF-C ==
    wget https://github.com/Unidata/netcdf-c/archive/v4.6.1.tar.gz
    tar -xzf v4.6.1.tar.gz
    cd netcdf-c-4.6.1
    # don't need remote access
    CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=${NCDIR} --disable-dap
    make -j4
    make install

    cd /tmp

    # == NetCDF-Fortran ==
    export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
    wget https://github.com/Unidata/netcdf-fortran/archive/v4.4.4.tar.gz
    tar -xzf v4.4.4.tar.gz
    cd netcdf-fortran-4.4.4
    CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib ./configure --prefix=${NFDIR}
    make -j4
    make install

    cd /tmp

    # ====================
    #   Install MPI
    # ====================

    # == MPICH ==
    # https://www.mpich.org/downloads/
    wget http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
    tar zxf mpich-3.2.1.tar.gz
    cd mpich-3.2.1
    ./configure prefix=/usr/local/mpich
    make -j4
    make install

    cd /tmp

    # ====================
    #   Clean up
    # ====================

    rm -rf /tmp/*

%environment
    # fix Singularity + Perl error
    # https://groups.google.com/a/lbl.gov/forum/#!msg/singularity/58Xr72oDfBg/m3Y7Nr_PBAAJ
    export LANG=C

    # gfortran7
    export PATH=/opt/rh/devtoolset-7/root/usr/bin:$PATH

    # ====================================
    # --- Same as GEOS-Chem classic  ---
    # ====================================

    export NETCDF_HOME=/usr
    export NETCDF_FORTRAN_HOME=/usr
    export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH # for libnetcdff.so

    export FC=gfortran
    export CC=gcc
    export CXX=g++

    export GC_BIN=$NETCDF_HOME/bin
    export GC_INCLUDE=$NETCDF_HOME/include
    export GC_LIB=$NETCDF_HOME/lib

    export GC_F_BIN=$NETCDF_FORTRAN_HOME/bin
    export GC_F_INCLUDE=$NETCDF_FORTRAN_HOME/include
    export GC_F_LIB=$NETCDF_FORTRAN_HOME/lib

    # ====================================
    # --- GCHP-specific settings  ---
    # ====================================

    export OMPI_CC=$CC
    export OMPI_CXX=$CXX
    export OMPI_FC=$FC
    export F77=$FC
    export F90=$FC
    export COMPILER=$FC # needed for gfortran?

    export MPI_ROOT=/usr/local/mpich
    export PATH=$MPI_ROOT/bin:$PATH
    export ESMF_COMM=mpich2

    # ====================================
    # --- Dirty fixes for MAPL  ---
    # ====================================

    # --- Fixes for header files ("#include <xxx.h>" statement) ---
    # mpi.h locates at /usr/include so MAPL can find it
    export CPATH=$GC_CODE_DIR/GCHP/Shared/MAPL_Base:$CPATH # MAPL_Generic.h
    export CPATH=$GC_CODE_DIR/GCHP/Shared/GFDL_fms/shared/include:$CPATH # fms_platform.h
    export CPATH=$GC_CODE_DIR/GCHP/gchp_standard/CodeDir/GCHP/ESMF/Linux/include:$CPATH # ESMF_ErrReturnCodes.inc

%runscript
    echo "Container for GCHP environment"
    echo "Please use run it interactively by, for example:"
    echo "SINGULARITYENV_GC_CODE_DIR=~/GCHP/Code.v11-02_gchp singularity shell GCHP.simg"
    echo "To enable coloring inside container, run:"
    echo 'alias ls="ls --color=auto"'