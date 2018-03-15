Use S3 as major storage
=======================

:ref:`S3 <s3-intro-label>` is the most important storage service on AWS. Knowing how to use it crucial for almost any projects on the cloud.

Use S3 from the console
-----------------------

Please follow `the official S3 tutorial <https://aws.amazon.com/getting-started/tutorials/backup-files-to-amazon-s3/>`_ to learn how to use S3 in the graphical console. It feels pretty much like Dropbox or Google Cloud Drive, which allows you to upload and download files by clicking on buttons. Before continuing, you should know how to:

1. Create a S3 bucket
2. Upload a file (also called "object" in S3 context) into that bucket
3. Download that file
4. Delete that file and Bucket

The S3 console is convenient for viewing files, but most of time you will use AWSCLI to work with S3 because:

- It is much easier to recurisively upload/download directories with AWSCLI. 
- To transfer data between S3 and EC2, you have to use AWSCLI since there is no graphical console on EC2 instances.
- To work with public data set, AWSCLI is almost the only way you can use. Recall that in the previous chapter you use ``aws s3 ls s3://nasanex/`` to list the NASA-NEX data. But you cannot see the "s3://nasanex/" bucket in S3 console, since it doesn't belong to you.

Working with S3 using AWSCLI
----------------------------

On an EC2 instance launched from the GEOSChem tutorial AMI, configure AWSCLI by ``aws configure`` as in the :ref:`previous chapter <awscli_configure-label>` and make sure ``aws s3 ls`` can run without error.

Now, say you've made some changes to the ``geosfp_4x5_standard/`` run directory, such as tweaking model configurations in ``input.geos`` or running simulations to produce new diagnostics files. You want to keep those changes after you terminate the server, so you can retrieve them when you continue the work next time.

Create a new bucket by ``aws s3 mb s3://your-bucket-name``. Note that S3 bucket names must be unique across all accounts, as this facilitates sharing data between different people (If others' buckets are public, you can access them just like how the owners access them). Getting a unique name is easy -- it the name already exists, just add your name initials or some prefix. If you just use the name in the exmaple below, you are likely to get an ``make_bucket failed`` error since that bucket already exists in my account::

  $ aws s3 mb s3://geoschem-run-directory
  make_bucket: geoschem-run-directory

Then you can see your bucket by ``aws s3 ls`` (you can also see it in the S3 console) ::

  $ aws s3 ls
  2018-03-09 18:54:18 geoschem-run-directory

Now use ``aws s3 cp local_file s3://your-bucket-name`` to transfer the directory to S3 (add the ``--recursive`` option is to recursively copy a directory, just like the normal Linux command ``cp -r``) ::

  $ aws s3 cp --recursive geosfp_4x5_standard s3://geoschem-run-directory/
  upload: geosfp_4x5_standard/FJX_spec.dat to s3://geoschem-run-directory/FJX_spec.dat
  upload: geosfp_4x5_standard/HEMCO.log to s3://geoschem-run-directory/HEMCO.log
  upload: geosfp_4x5_standard/HISTORY.rc to s3://geoschem-run-directory/HISTORY.rc
  ...

The default bandwidth between EC2 and S3 is ~100 MB/s so copying that run directory would just take seconds.

.. note::
  To make incremental changes to existing S3 buckets, ``aws s3 sync`` is more efficient then ``aws s3 cp``. Instead of overwriting the entire bucket, ``sync`` only write the files that have actually changed.

Now list your S3 bucket content by ``aws s3 ls s3://your-bucket-name``::

  $ aws s3 ls s3://geoschem-run-directory
  2018-03-09 19:13:45        364 .gitignore
  2018-03-09 19:13:45       9712 FJX_j2j.dat
  2018-03-09 19:13:45      50125 FJX_spec.dat
  ...

You can also see all the files in the S3 console, which is a quite convenient way to view your data without launching any servers.

Then, try to get data back from S3 by swapping the arguments to ``aws s3 cp``::

  ubuntu@ip-172-31-46-2:~$ aws s3 cp --recursive s3://geoschem-run-directory/ rundir_copy
  download: s3://geoschem-run-directory/.gitignore to rundir_copy/.gitignore
  download: s3://geoschem-run-directory/FJX_j2j.dat to rundir_copy/FJX_j2j.dat
  download: s3://geoschem-run-directory/FJX_spec.dat to rundir_copy/FJX_spec.dat
  ...

Since your run directory is now safely living in the S3 bucket that is independent to any servers, terminating your EC2 instance won't cause data loss. You can use ``aws s3 cp`` to get data back from S3, on any number of newly-launched EC2 instances. 

.. warning::
  S3 is not a standard Linux file system and thus cannot preserve Linux file permissions. After retrieving your run directory back from S3, the executable ``geos.mp`` and ``getRunInfo`` will not have execute-permission by default.
  Simply type ``chmod u+x geos.mp getRunInfo`` to grant permission again. 
  
  Another approach to preserve permissions is to use ``tar -zcvf`` to compress your directory before loading to S3, and then use ``tar -zxvf`` to decompress it after retrieving from S3. Only consider this approach if you absolutely want to preverse all the permission information. 
   
  S3 also has no concept of symbolic links created by ``ln -s``. By default, it will turn all links into real files by making real copies. You can use ``aws s3 cp --no-follow-symlinks ...`` to ignore links.
  
  Those simplifications make S3 much more scalable (and cheaper) than normal file systems. You just need to be aware of those caveats.

Access NASA-NEX data in S3 (Optional but recommended)
-----------------------------------------------------

Before accessing GEOS-Chem input data repository, let's play with some `NASA-NEX <https://nex.nasa.gov/nex/>`_ data first. `"NASA-NEX on AWS" <https://aws.amazon.com/public-datasets/nasa-nex/>`_ is one of the earliest "Earth data on cloud" project that was launch `around 2013 <https://aws.amazon.com/blogs/aws/process-earth-science-data-on-aws-with-nasa-nex/>`_. Unlike other newer projects that are still evolving (and might change constantly), the NASA-NEX repository is very stable, so it is a good starting example.

Let's download the `NEX-GDDP <https://cds.nccs.nasa.gov/nex-gddp/>`_ dataset produced by `CMIP5 <https://cmip.llnl.gov/cmip5/>`_::

  $ aws s3 ls s3://nasanex/NEX-GDDP/
                             PRE BCSD/
  2015-06-04 17:15:58          0
  2015-06-04 17:18:35         35 doi.txt
  2015-06-12 21:08:34    4346867 nex-gddp-s3-files.json
  
You can explore sub-directories by, for example::

  $ aws s3 ls s3://nasanex/NEX-GDDP/BCSD/
  $ aws s3 ls s3://nasanex/NEX-GDDP/BCSD/rcp85/
  $ aws s3 ls s3://nasanex/NEX-GDDP/BCSD/rcp85/day/
  $ aws s3 ls s3://nasanex/NEX-GDDP/BCSD/rcp85/day/atmos/
  $ aws s3 ls s3://nasanex/NEX-GDDP/BCSD/rcp85/day/atmos/tasmax/
  $ aws s3 ls s3://nasanex/NEX-GDDP/BCSD/rcp85/day/atmos/tasmax/r1i1p1/
  $ aws s3 ls s3://nasanex/NEX-GDDP/BCSD/rcp85/day/atmos/tasmax/r1i1p1/v1.0/
  
Or just get down to one of the the lowest level folders ::
  
  $ aws s3 ls --summarize --human-readable s3://nasanex/NEX-GDDP/BCSD/rcp85/day/atmos/tasmax/r1i1p1/v1.0/
  ...
  2015-09-25 21:07:06    8.3 KiB tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2099.json
  2015-06-10 22:48:30  759.0 MiB tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2099.nc
  2015-09-25 21:21:34    8.3 KiB tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2100.json
  2015-06-10 22:48:52  757.9 MiB tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2100.nc

  Total Objects: 3986
     Total Size: 1.4 TiB

The ``--summarize --human-readable`` options print the total size in human-readable formats (like the normal Linux command ``du -sh``) As you see, that subfolder has 1.4 TB of data. Just get one file to play with::
  
  $ aws s3 cp s3://nasanex/NEX-GDDP/BCSD/rcp85/day/atmos/tasmax/r1i1p1/v1.0/tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2100.nc ./
  download: s3://nasanex/NEX-GDDP/BCSD/rcp85/day/atmos/tasmax/r1i1p1/v1.0/tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2100.nc to ./tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2100.nc

With ~100 MB/s bandwidth, downloading this 750 MB file to EC2 should just take seconds. If you download it to a local machine with 1 MB/s bandwidth, it would take 10 minutes. Not to mention downloading the entire 200 TB NEX dataset to your machine!

It is the daily maximum surface air temperature under the `RCP 8.5 scenario <https://link.springer.com/article/10.1007/s10584-011-0149-y>`_::

  $ ncdump -h
  ubuntu@ip-172-31-46-2:~$ ncdump -h tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2100.nc
  netcdf tasmax_day_BCSD_rcp85_r1i1p1_inmcm4_2100 {
  dimensions:
  	time = UNLIMITED ; // (365 currently)
  	lat = 720 ;
  	lon = 1440 ;
  ...
  	float tasmax(time, lat, lon) ;
  		tasmax:time = 32850.5 ;
  		tasmax:standard_name = "air_temperature" ;
  		tasmax:long_name = "Daily Maximum Near-Surface Air Temperature" ;
  ...

Here's an :doc:`example notebook <../chapter06_appendix/plot_NASANEX>` to plot the data with Jupyter and xarray. See the previous :ref:`quick start guide <jupyter-label>` for starting Jupyter.

Congrats! You know how to access and analyze public datasets on AWS. Accessing GEOS-Chem's input data repository will be exactly the same.

.. note::
  
  Get tired of lengthy S3 commands? The `s3fs-fuse <https://github.com/s3fs-fuse/s3fs-fuse>`_ tool can make S3 buckets and objects behave just like normal directories and files on disk. We will mention it in advanced tutorials.

.. _gcdata-bucket-label:

Access GEOS-Chem input data repository in S3
--------------------------------------------

::
  
  $ aws s3 ls --request-payer=requester s3://gcgrid/
                             PRE BPCH_RESTARTS/
                             PRE CHEM_INPUTS/
                             PRE GCHP/
                             PRE GEOS_0.25x0.3125/
                             PRE GEOS_0.25x0.3125_CH/
                             PRE GEOS_0.25x0.3125_NA/
                             PRE GEOS_0.5x0.625_AS/
                             PRE GEOS_0.5x0.625_NA/
                             PRE GEOS_2x2.5/
                             PRE GEOS_4x5/
                             PRE GEOS_MEAN/
                             PRE GEOS_NATIVE/
                             PRE GEOS_c360/
                             PRE HEMCO/
                             PRE SPC_RESTARTS/
  2018-03-08 00:18:41       3908 README
  
GEOS-Chem input data bucket uses `requester-pay mode <https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html>`_. Transfering data from S3 to EC2 (in the same region) has no cost. But you do need to pay for the :ref:`egress fee <data-egress-label>` it you download data to local machines.

The tutorial AMI only has 1-month GEOS-FP metfield. You can get other metfields from that S3 bucket, to support simulations wtih any configurations.