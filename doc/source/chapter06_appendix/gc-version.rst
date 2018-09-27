Set up proper GEOS-Chem version
-------------------------------

Switching the model version is easy. No need to touch environment variables and library configurations. Any versions newer than `v11-02a <http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_v11-02#v11-02a>`_ should work smoothly. The system will still work with future releases of GEOS-Chem, unless there are big structural changes that break the compile process.

I just put essential steps here for reference. Existing GEOS-Chem users should feel quite familiar. New users should refer to our `user guide <http://acmg.seas.harvard.edu/geos/doc/man/>`_ for the full instruction.

Get source code and checkout model version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

After v11-02 formal release, you might want to clone from the main repository::

  git clone https://github.com/geoschem/geos-chem Code.12.0.1
  git clone https://github.com/geoschem/geos-chem-unittest.git UT

You may list all sub-versions (git tags) in chronological order::

  $ git log --tags --simplify-by-decoration --pretty="format:%ci %d"
  2018-08-22 16:57:08 -0400  (HEAD -> master, tag: 12.0.1, origin/master, origin/HEAD)
  2018-08-09 16:59:22 -0400  (tag: 12.0.0)
  2018-07-30 10:31:40 -0400  (tag: 12.0.0-1yr-bm, tag: 12.0.0-1mo-bm)
  2018-06-21 10:04:24 -0400  (tag: v11-02-release-candidate, tag: v11-02-rc)
  2018-05-11 16:31:42 -0400  (tag: v11-02f-1yr-Run1)
  ...

If needed, checkout to a different version, say ``12.0.0``::

  $ git checkout 12.0.0
  $ git branch
  * (HEAD detached at 12.0.0)

You need to do version checkout for both source code and unit tester.

Configure unit tester and generate run directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here's how I set up the tutorial run directory, for reference.

In ``UT/perl/CopyRunDirs.input``, change the default paths::

  GCGRID_ROOT    : /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid
  DATA_ROOT      : {GCGRIDROOT}/data/ExtData
  ...
  UNIT_TEST_ROOT : {HOME}/UT
  ...
  COPY_PATH      : {HOME}/GC/rundirs

to::

  GCGRID_ROOT    : /home/ubuntu
  DATA_ROOT      : {GCGRIDROOT}/ExtData
  ...
  UNIT_TEST_ROOT : {HOME}/tutorial/UT
  ...
  COPY_PATH      : {HOME}/tutorial

Then uncomment the run directory I want::

  geosfp   4x5         -      standard         2013070100   2013080100     -
  
In ``ut_bleeding_edge/perl/Makefile``, change the source code path::

    CODE_DIR    :=$(HOME)/GC/Code.$(VERSION)

to::

    CODE_DIR    :=$(HOME)/tutorial/Code.$(VERSION)

Running ``git status -v`` inside ``~/tutorial/ut_bleeding_edge`` will display all those modifications. 

Finally, generate the run directory::

  $ ./gcCopyRunDirs

Go to the run directory and compile::

  $ make -j4 mpbuild NC_DIAG=y BPCH_DIAG=n TIMERS=1

Note that you almost have to execute ``make`` command **in the run directory**. This will ensure the correct combination of compile flags for this specific run configuration. GEOS-Chem's compile flags have become so complicated that you will almost never get the right compile settings by compiling in the source code directory. See `our wiki <http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_Makefile_Structure#Compiling_in_a_run_directory>`_ for more information.