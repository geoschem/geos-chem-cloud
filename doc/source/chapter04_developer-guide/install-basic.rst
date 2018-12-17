Install compilers and commonly-used libraries
=============================================

Start with a fresh operating system
-----------------------------------

The `AWS official "10-minute" tutorial <https://aws.amazon.com/getting-started/tutorials/launch-a-virtual-machine/>`_ shows how to launch an EC2 instance with a fresh Linux system. The only difference from our :ref:`quick start guide <quick-start-label>` is in "Step 1: Choose an Amazon Machine Image (AMI)". Instead of starting with our tutorial AMI, here you select a basic AMI with almost nothing installed. 

AWS recommends their `Amazon Linux AMI <https://aws.amazon.com/amazon-linux-ami/>`_; many other options are also available:

.. figure:: img/select-ami.png

So which to choose? Recall that Linux distributions fall into two big categories:

1. **The Debian family**, such as `Debian GNU/Linux <https://en.wikipedia.org/wiki/Debian>`_ and `Ubuntu <https://en.wikipedia.org/wiki/Ubuntu_(operating_system)>`_. They use ``apt`` as the high-level package manager and ``dpkg`` as the low-level one.

2. **The Red Hat family**, such as `Red Hat Enterprise Linux (RHEL) <https://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux>`_ and `CentOS <https://en.wikipedia.org/wiki/CentOS>`_. Amazon Linux also belongs to this family. They use ``yum`` as the high-level package manager and ``rpm`` as the low-level one.

Ubuntu tends to have the largest user base; CentOS is widely used on HPC clusters and is very tolerant of legacy software code; Amazon Linux has the most native AWS support.

Here we use Ubuntu 18.04 LTS ``ami-0ac019f4fcb7cb7e6`` as an example, because it has many up-to-date, pre-packaged libraries available and is most painless to work with.

To test software installation, a small instance like ``t2.micro`` is often good enough. 

C, C++, and Fortran compilers
-----------------------------

After log-in, first update the package lists::

  $ sudo apt-get update

We use the GNU compiler family which is free, open source, and easy to install::

  $ sudo apt-get install gcc gfortran g++

.. note::

  Alternatively, you can `install Intel compilers <https://software.intel.com/en-us/articles/installing-intel-parallel-studio-xe-on-aws-linux-instances>`_ if you have the license, or `PGI compilers <http://www.pgroup.com/index.htm>`_ for CUDA Fortran and OpenACC support.

Executables will be installed to ``/usr/bin/``::

  $ which gcc gfortran g++
  /usr/bin/gcc
  /usr/bin/gfortran
  /usr/bin/g++

By default the package manager gets 7.3.0::

  $ gcc --version
  gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0

You can also install higher versions, for example::

  $ sudo apt-get install gcc-8 gfortran-8 g++-8
  $ gcc-8 --version
  gcc-8 (Ubuntu 8.2.0-1ubuntu2~18.04) 8.2.0

NetCDF library
--------------

Install NetCDF with package manager
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The `NetCDF library <https://www.unidata.ucar.edu/software/netcdf/>`_ is ubiquitous in Earth science models. Getting it from the package manager is extremely easy::

  $ sudo apt-get install libnetcdf-dev libnetcdff-dev

Note that "dev" stands for "development tool", because it contains header files for compiling models. (It is not "developing version" -- the package repository is mature and stable!) Also note that after NetCDF version 4.2, the NetCDF-C and NetCDF-Fortran libraries are installed separately.

Check NetCDF-C configuration::

  $ nc-config --all

  This netCDF 4.6.0 has been built with the following features:
  ...

Check NetCDF-Fortran configuration::

  $ nf-config --all

  This netCDF-Fortran 4.4.4 has been built with the following features:
  ...
  --prefix    -> /usr
  --includedir-> /usr/include
  --version   -> netCDF-Fortran 4.4.4
  
``--includedir`` will be used to include this NetCDF library when compiling Fortran code.


Test sample NetCDF code
^^^^^^^^^^^^^^^^^^^^^^^

Get some `sample code <https://www.unidata.ucar.edu/software/netcdf/examples/programs/>`_, such as `simple_xy_wr.f90 <https://www.unidata.ucar.edu/software/netcdf/examples/programs/simple_xy_wr.f90>`_.

::

  $ wget https://www.unidata.ucar.edu/software/netcdf/examples/programs/simple_xy_wr.f90
  $ gfortran simple_xy_wr.f90 -o test_nc.exe -I/usr/include -lnetcdff
  $ ./test_nc.exe
  *** SUCCESS writing example file simple_xy.nc!

Install ``ncdump`` to check file content::

  $ sudo apt-get install netcdf-bin
  $ ncdump -h simple_xy.nc
  netcdf simple_xy {
  dimensions:
  	x = 6 ;
  	y = 12 ;
  variables:
  	int data(x, y) ;
  }

(Optional) Build NetCDF from source
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You might want to build NetCDF from source if:

1. To ensure the latest version. Package managers are not necessarily up-to-date (although Ubuntu 18.04's package repository contains a very recent NetCDF).
2. To be compatible with other versions of compilers. The above NetCDF library got from package manager is compiled with gfortran 7, and cannot be used with gfortran 8.
3. To install into a different directory. Package managers typically install libraries into ``/usr``.

Doing so is quite tedious so we will not go through it here. Please refer to `NetCDF official page <https://www.unidata.ucar.edu/software/netcdf/docs/getting_and_building_netcdf.html>`_.

For NetCDF library, you generally won't get better performance by compiling it from source with better optimized compiler settings, because NetCDF is just an I/O library, not for numerical computation. However, for other compute-oriented libraries, compiling from source can sometimes make a big difference in performance.


MPI library
-----------

`Message Passing Interface (MPI) <https://computing.llnl.gov/tutorials/mpi/>`_ is also ubiquitous in Earth science models. Popular MPI implementations include:

- `Open MPI <https://www.open-mpi.org>`_
- `MPICH <https://www.mpich.org>`_
- `MVAPICH <http://mvapich.cse.ohio-state.edu>`_
- `Intel MPI <https://software.intel.com/en-us/mpi-library>`_

Install MPI with package manager
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We use Open MPI as the example::

  $ sudo apt-get install libopenmpi-dev
  $ which mpirun mpicc mpifort mpic++
  /usr/bin/mpirun
  /usr/bin/mpicc
  /usr/bin/mpifort
  /usr/bin/mpic++

.. note::
  MPICH can be also installed by ``sudo apt-get install libmpich-dev``. To avoid messing up executables, do not install both. To test multiple versions&implementations of MPI, see building from source code below.

Check MPI version::

  $ mpirun --version
  mpirun (Open MPI) 2.1.1

Show the full command of the ``mpicc`` wrapper (OpenMPI-only feature)::

  $ mpicc --show
  gcc -I/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi -I/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent -I/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent/include -I/usr/lib/x86_64-linux-gnu/openmpi/include -pthread -L/usr//lib -L/usr/lib/x86_64-linux-gnu/openmpi/lib -lmpi

Test sample MPI code
^^^^^^^^^^^^^^^^^^^^

Get sample code like `hello.c <https://www.open-mpi.org/papers/workshop-2006/hello.c>`_::

  $ wget https://www.open-mpi.org/papers/workshop-2006/hello.c
  $ mpicc -o hello.exe hello.c
  $ mpirun -np 2 ./hello.exe
  Hello, World.  I am 1 of 2
  Hello, World.  I am 0 of 2

(Optional) Build MPI from source
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Newer versions and other MPI implementations generally need to be built from source. For example, getting `OpenMPI 3 <https://www.open-mpi.org/software/ompi/v3.1/>`_::

  $ wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.3.tar.gz
  $ tar zxf openmpi-3.1.3.tar.gz
  $ cd openmpi-3.1.3
  $ ./configure prefix=/usr/local/
  $ make
  $ sudo make install
  $ sudo ldconfig  # fix library linking https://askubuntu.com/a/1100000

Recall that building software from source all follow the same `configure, make, make install <https://robots.thoughtbot.com/the-magic-behind-configure-make-make-install>`_ steps.

New executables will be in ``{prefix}/bin`` as specified in ``./configure`` above::

  $ which mpirun mpicc mpifort mpic++
  /usr/local/bin/mpirun
  /usr/local/bin/mpicc
  /usr/local/bin/mpifort
  /usr/local/bin/mpic++

  $ mpirun --version
  mpirun (Open MPI) 3.1.3

Install scientific Python environment
-------------------------------------

Do not use the system Python installation. Just `install Anaconda/Miniconda <https://conda.io/docs/user-guide/install/index.html>`_. It doesn't require root access and can be easily installed into almost any environment (including shared HPC clusters).

Scripts used for the tutorial AMI are `available for reference <https://github.com/geoschem/geos-chem-cloud/tree/master/scripts/build_environment/python>`_.

Additional tools
----------------

For Emacs users::

  $ sudo apt-get install emacs

For git-gui users::

  $ sudo apt-get install git-gui