Set up proper GEOS-Chem version
-------------------------------

Our tutorial AMI uses `v11-02d <http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_v11-02#v11-02d>`_ as a demo but it is very easy to switch to a different version you want. No need to touch environment variables and library configurations. Any versions newer than `v11-02a <http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_v11-02#v11-02a>`_ should work smoothly. The system will still work with future releases of GEOS-Chem (e.g. v11-02 formal release), unless there are big structural changes that break the compile process.

I just put essential steps here for reference. Existing GEOS-Chem users should feel quite familiar. New users should refer to our `user guide <http://acmg.seas.harvard.edu/geos/doc/man/>`_ for the full instruction.

Get source code and checkout model version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For now I use the "bleeding edge" repository::

  git clone https://bitbucket.org/gcst/gc_bleeding_edge.git
  git clone https://bitbucket.org/gcst/ut_bleeding_edge.git

After v11-02 formal release, you might want to clone from the main repository::

  git clone https://bitbucket.org/gcst/geos-chem.git
  git clone https://bitbucket.org/gcst/geos-chem-unittest.git

You may list all sub-versions (git tags) in chronological order::

  $ git log --tags --simplify-by-decoration --pretty="format:%ci %d"
  2018-01-25 09:58:33 -0500  (tag: v11-02d-Run2, origin/master, origin/HEAD, master)
  2017-12-21 16:53:01 -0500  (tag: v11-02d-Run1)
  2017-12-06 18:07:17 -0500  (tag: v11-02d-prelim)
  2017-12-01 14:48:35 -0500  (tag: v11-02d-Run0)
  2017-09-11 15:50:37 -0400  (tag: v11-02c)
  ...

If needed, checkout to a different version, say ``v11-02c``::

  $ git checkout v11-02c
  HEAD is now at 2b07df6... Avoid array out-of-bounds error in EMISSCARBON when complex SOA is off
  $ git branch
  * (HEAD detached at v11-02c)

You need to do version checkout for both source code and unit tester.

Configure unit tester and generate run directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here's how I set up the tutorial run directory, for reference.

In ``ut_bleeding_edge/CopyRunDirs.input``, change the default paths::

  GCGRID_ROOT    : /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid
  DATA_ROOT      : {GCGRIDROOT}/data/ExtData
  ...
  UNIT_TEST_ROOT : {HOME}/UT
  ...
  COPY_PATH      : {HOME}/GC/rundirs

to::

  GCGRID_ROOT    : /home/ubuntu/gcdata
  DATA_ROOT      : {GCGRIDROOT}/ExtData
  ...
  UNIT_TEST_ROOT : {HOME}/tutorial/ut_bleeding_edge
  ...
  COPY_PATH      : {HOME}/tutorial

Then uncomment the run directory I want::

  geosfp   4x5         -      standard         2013070100   2013080100     -
  
In ``ut_bleeding_edge/Makefile``, change the source code path::

    CODE_DIR    :=$(HOME)/GC/Code.$(VERSION)

to::

    CODE_DIR    :=$(HOME)/tutorial/gc_bleeding_edge

Running ``git status -v`` inside ``~/tutorial/ut_bleeding_edge`` will display all those modifications. 

Finally, generate the run directory::

  $ ./gcCopyRunDirs

Go to the run directory and compile::

  $ make -j4 mpbuild NC_DIAG=y BPCH_DIAG=n TIMERS=1

Note that you almost have to execute ``make`` command **in the run directory**. This will ensure the correct combination of compile flags for this specific run configuration. GEOS-Chem's compile flags have become so complicated that you will almost never get the right compile settings by compiling in the source code directory. See `our wiki <http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_Makefile_Structure#Compiling_in_a_run_directory>`_ for more information.