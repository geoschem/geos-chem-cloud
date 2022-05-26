Put everything together: a complete workflow
============================================

Congrats! If you've been reading the tutorials in order, now you should know enough AWS stuff to perform most of simulation, data analysis, and data management tasks. These tutorials could feel pretty intense if you are new to cloud computing (although I really tried to make them as user-friendly as possible). Don't worry, repeat these practices several times and you will get familiar with the research workflow on the cloud very quickly. There are also advanced tutorials, but they are just add-ons and are really not necessary for just getting science done.

General comments on cloud vs local computer
-------------------------------------------

The major difference (in terms of research workflow) between local HPC clusters and cloud platforms is **data management**, and that's what new users might feel uncomfortable with. To get used to the cloud, the key is to use and love S3! On traditional local disks, any files you create will stay there forever (so I often end up leaving tons of random legacy files in my home directory). On the other hand, the pricing model of cloud storage (charge you by the exact amount of data) will force you to really think about what files should kept by transferring to S3, and what should be simply discarded (e.g. TBs of legacy data that are not used anymore).

There are also ways to make cloud platforms :ref:`behave like traditional HPC clusters <hpc-overview-label>`, but they can often bring more restrictions than benefits. To fully utilize the power and flexibility of cloud platforms, directly use native, basic services like EC2 and S3.

A reference workflow
--------------------

Here's the outline of a typical research workflow:

1. Launch EC2 instances from pre-configured AMI. Consider spot instances for big computing. :doc:`Consider AWSCLI to simply the above process to one shell command <../chapter03_advanced-tutorial/advanced-awscli>`
2. Tweak model configurations as needed.
3. Pull necessary input data from S3 to EC2. Put commonly used ``aws s3 cp`` commands into bash scripts.
4. Run simulations :ref:`with tmux <keep-running-label>`. Log out and go to sleep if the model runs for a long time. Re-login at anytime to check progress.
5. Use Python/Jupyter to analyze output data.
6. When the EC2 instance is not needed anymore, transfer output data and customized model configuration (mostly run directories) to S3. Or download them to local machines if necessary (Recall that :ref:`egress charge <data-egress-label>` is $90/TB; for several GBs the cost is negligible).
7. Once important data safely live on S3 or on your local machine, shut down EC2 instances to stop paying for CPU charges.
8. Go to write papers, attend meetings, do anything other than computing. During this time, no machines are running on the cloud, and the only cost is data storage on S3 ($23/TB/month).
9. Whenever need to continue computing, launch new EC2 instances, pull previous data from S3.

Talk is cheap. Let's actually walk through them.

Below are reproducible steps (copy & paste-able commands) to set up a custom model run. We use a one-month, 2x2.5 simulation as an example, but the same idea applies to other types of runs. **Most laborious steps only need to be done once**. Subsequent workflow will be much simpler.

I assume you've read all previous sections. Don't worry if you can't remember everything -- there will be links to previous sections whenever necessary.

Launch EC2 instance with custom configuration
---------------------------------------------

A complete EC2 configuration has 7 steps, with tons of options throughout the steps:

.. figure:: img/EC2_launch_seven_steps.png

You typically only touch very few options, as listed in order below.

- Choose our tutorial AMI :ref:`just as in the quick start guide <choose_ami-label>`. This effectively did "Step 1: Choose an Amazon Machine Image (AMI)". You will be brought to "Step 2: Choose an Instance Type".

* At Step 2, choose the "Compute optimized" family, select ``c5.4xlarge``, which is suitable for medium-sized simulations. For longer-term, higher-resolution runs, consider even bigger ones like ``c5.9xlarge`` and ``c5.18xlarge``.

- At "Step 3, Configure Instance Details", select "Request Spot instances". :doc:`See here to review spot instances configuration <spot-instances>`. (At this step you also have the chance to select an "IAM role" to simplify AWSCLI configuration for S3, as :doc:`explained in advanced tutorial <../chapter03_advanced-tutorial/iam-role>`.)

* At "Step 4: Add Storage", **increase the size to 400~500 GB** to host more input/output data. :doc:`See here to review EBS volume configuration <use-ebs>`.

- Nothing to do for "Step 5: Add Tags". Just go to the next step. You can always add `resource tags <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html>`_ (just convenient labels) anytime later.

* At "Step 6: Configure Security Group", select a proper security group. :doc:`See here to review security group configuration <security-group>`. If you don't bother with security group configurations, simply choose "Create a new security group" (it works but not optimal).

- Nothing to do for "Step 7: Review Instance Launch". Just click on "Launch".

Occasionally you might `hit EC2 instance limit <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html>`_, especially when you try to launch a very large instance on a new account. Just `request for limit increase <https://aws.amazon.com/premiumsupport/knowledge-center/ec2-instance-limit/>`_. if that happens.

Advanced tutorial will show you how to :doc:`use AWSCLI to simply the above process to one shell command <../chapter03_advanced-tutorial/advanced-awscli>`.

.. _custom-gc-label:

Set up your own model configuration
-----------------------------------

Log into the instance :ref:`as in the quick start guide <login_ec2-label>`. Here you will set up you own model configuration, instead of using the pre-configured tutorial run directory. The system will still work with future releases of GEOS-Chem, unless there are big structural changes that break the compile process.

Existing GEOS-Chem users should feel quite familiar about the steps presented here. New users might need to refer to our `user guide <http://acmg.seas.harvard.edu/geos/doc/man/>`_ for more complete explanation.

Get source code and checkout model version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can obtain the latest copy of the code from `GEOS-Chem's GitHub repo <https://github.com/geoschem>`_::

  $ mkdir ~/GC  # make you own folder instead using the "tutorial" folder.
  $ cd ~/GC
  $ git clone https://github.com/geoschem/GCClassic.git Code.GC

You may list all versions (they are just `git tags <https://git-scm.com/book/en/v2/Git-Basics-Tagging>`_) in chronological order::

  $ cd Code.GC
  $ git log --tags --simplify-by-decoration --pretty="format:%ci %d"
  2021-01-12 16:02:14 -0700  (HEAD -> main, tag: 13.0.0-rc.1, origin/main, origin/HEAD)
  2021-01-08 11:03:08 -0500  (tag: 13.0.0-rc.0, tag: 13.0.0-beta.2)
  2020-11-20 15:34:09 -0500  (tag: 13.0.0-beta.1)
  2020-11-01 20:13:53 -0500  (tag: 13.0.0-beta.0, tag: 13.0.0-alpha.13)
  2020-10-23 14:28:07 -0400  (tag: 13.0.0-alpha.12)

  ...
  
**New users had better just use the default, latest version to minimize confusion**. Experienced users might want to checkout to a specific version, say ``13.0.0-alpha.12``::

    $ git checkout 13.0.0-alpha.12  # just the name of the tag
    $ git branch
    * (HEAD detached at 13.0.0-alpha.12)
    $ git checkout main  # restore the latest version if you want

As of version 13.0.0, GEOS-Chem uses Git submodules to facilitate easier development and reuse of independent segments of code.
**You must perform an extra step to fetch required submodule code**::

  $ git submodule update --init --recursive
  

Generate run directory
^^^^^^^^^^^^^^^^^^^^^^

Then you need to generate your run directory::

  $ cd ~/GC/Code.GC/run
  $ ./createRunDir.sh

You'll receive a series of prompts such as the following::

  -----------------------------------------------------------
  Choose simulation type:
  -----------------------------------------------------------
     1. Full chemistry
     2. Aerosols only
     3. CH4
     4. CO2
     5. Hg
     6. POPs
     7. Tagged CH4
     8. Tagged CO
     9. Tagged O3
     10. TransportTracers

At each prompt, type the digit corresponding to the option you want to select.

When asked to input a run directory path, type ``~/GC/rundirs``.


Go to the generated run directory (the name will differ based on which options you chose and whether you chose to give the run directory
a custom name). You'll compile the model from inside of the ``build/`` folder in your run directory::

  $ cd ~/GC/rundirs/YOUR_RUN_DIRECTORY
  $ cd build/
  $ cmake ../CodeDir -DRUNDIR=..
  $ make -j
  $ make install
  $ cd ..
  $ ls

You should see a ``gcclassic`` executable file in your run directory now, indicating compilation was successful.


Tweak run-time configurations as needed
---------------------------------------

For example, in ``input.geos``, check if the simulation length is one month::

  Start YYYYMMDD, hhmmss  : 20190701 000000
  End   YYYYMMDD, hhmmss  : 20190801 000000

You might also want to tweak ``HEMCO_Config.rc`` to select emission inventories, and ``HISTORY.rc`` to select output fields.

Get more input data from S3
---------------------------

You'll likely need input data beyond the fields already included for the demo 4x5 simulation. You can automatically retrieve any required files 
using GEOS-Chem's dry-run capability. The fastest dry-run download destination on your AWS instance is from AWS S3.
You'll need to configure AWSCLI in order to be able to fetch data from AWS S3. You can configure AWSCLI using either
:ref:`configure credentials (beginner approach) <credentials-label>` or 
:doc:`configure IAM role (advanced approach) <../chapter03_advanced-tutorial/iam-role>`. Then use the following commands to download all 
required input data::

  $ ./gcclassic --dryrun | tee log.dryrun
  $ ./download_data.py log.dryrun --aws
  

Perform long-term simulation
----------------------------

A long simulation can take about a day. :ref:`With tmux <keep-running-label>`, you can keep the program running after logging out. 

::

  $ tmux
  $ ./gcclassic | tee run.log
  Type `Ctrl + b`, and then type `d`, to detach from the tmux session
  
  $ tail -f run.log  # display the output message dynamically
  Type `Ctrl + c` to quit the message display. Won't affect model simulation.

Log out of the server (``Ctrl + d`` or just close the terminal). The model will be safely running in the background. You can re-login anytime and check the progress by looking at ``run.log``. If you need to cancel the simulation, type ``tmux a`` to resume the interactive session and then ``Ctrl + c`` to kill the program.

.. note::
  What if the model finishes at mid-night? Any way to automatically terminate the instance to stop paying for charge? I tried multiple auto-checking methods but they often bring more troubles than benefits. For example, :ref:`the HPC cluster solution <hpc-overview-label>` will handle server termination for you, but that often makes the workflow more complicated, especially if you are not a heavy user. Manually examining the simulation on next day is usually the easiest way. The cost of EC2 piles up for simulations that last for many days, but for just one night it is negligible.

Analyze output data
-------------------

Output data will be generated during simulation as specified by ``HISTORY.rc``. You can :ref:`use Jupyter notebooks <jupyter-label>` to analyze them, or simply ``ipython`` for a quick check.
`GCPy <https://gcpy.readthedocs.io/en/latest/index.html>`_ (already installed on your instance in the ``geo`` conda environment) is another option for plotting and tabling GEOS-Chem data.

Save your files to S3
---------------------

Before you terminate your EC2 instance, always make sure that input files are transferred to persistent storage (S3 or local). Here we push our custom files to S3 (:ref:`see here to review S3+AWSCLI usage <s3-awscli_label>`).

::

  aws s3 mb s3://my-custom-gc-files  # use a different name for the bucket, with all lower cases
  aws s3 cp --recursive ~/GC/ s3://my-custom-gc-files  # transfer data
  aws s3 ls s3://my-custom-gc-files/  # show the bucket content

Only the ``~/GC/`` folder contains custom configurations. Input data can be easily retrieved from the ``s3://gcgrid`` bucket. However, if you made you own changes to the input data, remember to also transfer them to S3.

Terminate server, start over whenever needed
--------------------------------------------

Now you can safely :ref:`terminate the server <terminate-label>`. The next time you want to continue working on this project, **you only need to do two simple things**:

1. Launch EC2 instance. It takes one second if you :doc:`use AWSCLI <../chapter03_advanced-tutorial/advanced-awscli>`.

2. Retrieve data files. In this example, the commands are:

::

  # Assume that AWSCLI is already configured by either credentials or IAM roles
  
  # customized code, config files, and output data
  aws s3 cp --recursive s3://my-custom-gc-files ~/GC/
  chmod u+x ~/GC/your_rundir_name/gcclassic  # restore execution permission
  
  # standard input data from public bucket
  aws s3 cp --request-payer=requester --recursive \
  s3://gcgrid/GEOS_2x2.5/GEOS_FP/2011/01/ ~/ExtData/GEOS_2x2.5/GEOS_FP/2011/01/
  aws s3 cp --request-payer=requester --recursive \
  s3://gcgrid/GEOS_2x2.5/GEOS_FP/2016/07/ ~/ExtData/GEOS_2x2.5/GEOS_FP/2016/07/

The files on this new EC2 instance will look exactly the same as on the original instance that you terminated last time. In this way, you can get a sustainable workflow on the cloud.
