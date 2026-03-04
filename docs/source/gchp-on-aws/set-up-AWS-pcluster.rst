.. _using_aws_parallelcluster:

Quickstart II: Set up AWS ParallelCluster
==========================

.. important::

    AWS ParallelCluster and (:ref:`FSx for Lustre <term-fsx-lustre>`) costs hundreds or thousands of dollars per month.
    Please review `FSx for Lustre Pricing <https://aws.amazon.com/fsx/lustre/pricing/>`_ and
    `EC2 Pricing <https://aws.amazon.com/ec2/pricing/on-demand/>`_ for details.


AWS ParallelCluster is a service that allows you to deploy and manage your own HPC cluster in the cloud. Running GCHP on AWS ParallelCluster is similar to using GCHP on any other HPC.
We offer up-to-date Amazon Machine Images (AMIs) with GCHP's built dependencies. The available AMIs are listed below:

=========================   ============    ===================      ===================
AMI ID                      OS              architecture             pcluster version
=========================   ============    ===================      ===================
ami-061ca4ddb4e1ebd63       alinux2023      x86_64                   3.13.0
=========================   ============    ===================      ===================


The image contains pre-built tools for creating a GCHP run directory and compiling the model. 

.. important::

   **Spack Environment Required**
   
   This AMI uses Spack to manage software dependencies. You must activate the GCHP environment 
   before compiling or running the model:

   .. code-block:: console

      $ spack env activate gchp

This page has instructions on using the AMIs to create your own ParallelCluster.
You may also choose to set up AWS ParallelCluster manually, and the other GCHP documentation like :ref:`Build GCHP's dependencies <spackguide>`, :ref:`downloading_gchp`, :ref:`building_gchp`, :ref:`downloading_input_data`, and :ref:`running_gchp` is applicable for using GCHP on AWS ParallelCluster.

**Workflow for getting started with GCHP simulations on AWS ParallelCluster using our public AMIs:**

#. Create an FSx for Lustre file system for input data (:ref:`described here <create_fsx_for_lustre>`)
#. Configure AWS CLI (:ref:`described here <aws_cli_setup>`)
#. Configure AWS ParallelCluster (:ref:`described here <creating_your_pcluster>`)
#. Create AWS ParallelCluster with GCHP public AMIs (:ref:`described here <creating_your_pcluster>`)
#. Follow the normal GCHP User Guide

   a. :ref:`creating_a_run_directory`
   #. :ref:`downloading_input_data`

#. Running GCHP on ParallelCluster (:ref:`described here <create_fsx_for_lustre>`)

These instructions were tested using AWS ParallelCluster 3.13.0.

.. _create_fsx_for_lustre:

1. Create an FSx for Lustre file system
---------------------------------------

Start by creating an FSx for Lustre file system.
This is persistent storage that will be mounted to your AWS ParallelCluster cluster.
This file system will be used for storing GEOS-Chem input data as well as housing your GEOS-Chem run directories.

Refer to the official `FSx for Lustre Instructions <https://docs.aws.amazon.com/fsx/latest/LustreGuide/getting-started-step1.html>`_ for instructions on creating the file system.
Only Step 1, *Create your Amazon FSx for Lustre file system*, is necessary.
Step 2, *Install the Lustre client*, and subsequent steps have instructions for mounting your file system to EC2 instances, but AWS ParallelCluster automates this for us.

Record the following details about your new file system for later steps:

* its ID (:literal:`fs-XXXXXXXXXXXXXXXXX`)
* its subnet (:literal:`subnet-YYYYYYYYYYYYYYYYY`)
* its security group that has the inbound network rules (:literal:`sg-ZZZZZZZZZZZZZZZZZ`).

Once you have created the file system, proceed with :ref:`aws_cli_setup`.

.. _aws_cli_setup:

2. AWS CLI Installation and First-Time Setup
--------------------------------------------

Ensure you have the AWS CLI installed and configured.
The AWS CLI is a terminal command, :literal:`aws`, for working with AWS services.
If you have already installed and configured the AWS CLI previously, continue to :ref:`creating_your_pcluster`.

Install the :literal:`aws` command: `Official AWS CLI Install Instructions <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>`_.
Once you have installed the :literal:`aws` command, you need to configure it with the credentials for your AWS account:

.. code-block:: console

   $ aws configure

For instructions on :literal:`aws configure`, refer to the `Official AWS Instructions <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>`_ or `this YouTube tutorial <https://www.youtube.com/watch?v=Rp-A84oh4G8>`_.

.. _creating_your_pcluster:

3. Create your AWS ParallelCluster
----------------------------------

.. note::
  We recommend referring to the official AWS documentation on `Configuring AWS ParallelCluster <https://docs.aws.amazon.com/parallelcluster/latest/ug/install-v3-configuring.html>`_.
  Those instructions will have the latest information on using AWS ParallelCluster.
  The instructions on this page are meant to supplement the official instructions, and point out the important parts of the configuration for use with GCHP.

**Step 3a: Create a Key Pair**

Make sure you already have a key pair before moving on.
A key pair is needed as your secure identity credential to access your cluster's head node.
You can create the key pair using the AWS Management Console or the AWS CLI:

.. code-block:: console

    $ aws ec2 create-key-pair --key-name <your-keypair-name> --query 'KeyMaterial' --output text > <your-keypair-name>.pem

If you lose the private key, you will need to create a new key pair. Set strict permissions for your keypair:

.. code-block:: console

    $ chmod 400 <your-keypair-name>.pem

**Step 3b: Install AWS ParallelCluster**

Install `AWS ParallelCluster <https://docs.aws.amazon.com/parallelcluster/latest/ug/parallelcluster-version-3.html>`_ using :literal:`pip` (requires Python 3).
If you are using an AMI, make sure the parallelcluster version matches your AMI.

.. code-block:: console

   $ pip install "aws-parallelcluster==3.13.0"

You can use the :literal:`pcluster` command to performs actions like: creating a cluster, shutting your cluster down (temporarily), destroying a cluster, etc.

**Step 3c: Configure Your Cluster**

Generate a configuration file:

.. code-block:: console

   $ pcluster configure --config cluster-config.yaml

For instructions on :literal:`pcluster configure`, refer to the official instructions `Configuring AWS ParallelCluster <https://docs.aws.amazon.com/parallelcluster/latest/ug/install-v3-configuring.html>`_.

When prompted, we recommend the following settings:

* **Scheduler:** slurm
* **Operating System:** alinux2023
* **Head node instance type:** c5n.large
* **Number of queues:** 1
* **Compute instance type:** c5n.18xlarge
* **Maximum instance count:** [Your Choice] (This sets the limit for concurrent execution nodes).
  Execution nodes automatically spinup and shutdown according when there are jobs in your queue.

**Step 3d: Customize Configuration**

Now you should have a file name :file:`cluster-config.yaml`.
This is the configuration file with setting for a cluster.

Modify the generated :file:`cluster-config.yaml` to use the GCHP AMI and mount your FSx for Lustre file system.
Use the template below, ensuring you replace the placeholder values (e.g., `subnet-YYYY...`) with your specific IDs from Step 1.

.. code-block:: yaml

   Region: us-east-1  # [replace with] the region with your FSx for Lustre file system
   Image:
     Os: alinux2023
     CustomAmi: ami-061ca4ddb4e1ebd63  # [replace with] the AMI ID you want to use
   HeadNode:
     InstanceType: c5n.large  # smallest c5n node to minimize costs when head-node is up
     Networking:
       SubnetId: subnet-YYYYYYYYYYYYYYYYY  # [replace with] the subnet of your FSx for Lustre file system
       AdditionalSecurityGroups:
         - sg-ZZZZZZZZZZZZZZZZZ  # [replace with] the security group with inbound rules for your FSx for Lustre file system
     LocalStorage:
       RootVolume:
         VolumeType: gp3
     Ssh:
       KeyName: AAAAAAAAAA  # [replace with] the name of your ssh key name for AWS CLI
   SharedStorage:
     - MountDir: /fsx  # [replace with] where you want to mount your FSx for Lustre file system
       Name: FSxExtData
       StorageType: FsxLustre
       FsxLustreSettings:
         FileSystemId: fs-XXXXXXXXXXXXXXXXX  # [replace with] the ID of your FSx for Lustre file system
   Scheduling:
     Scheduler: slurm
     SlurmQueues:
     - Name: main
       ComputeResources:
       - Name: c5n18xlarge
         InstanceType: c5n.18xlarge
         MinCount: 0
         MaxCount: 10  # max number of concurrent exec-nodes
         DisableSimultaneousMultithreading: true  # disable hyperthreading (recommended)
         Efa:
           Enabled: true
       Networking:
         SubnetIds:
         - subnet-YYYYYYYYYYYYYYYYY  # [replace with] the subnet of your FSx for Lustre file system (same as above)
         AdditionalSecurityGroups:
           - sg-ZZZZZZZZZZZZZZZZZ  # [replace with] the security group with inbound rules for your FSx for Lustre file system
         PlacementGroup:
           Enabled: true
       ComputeSettings:
         LocalStorage:
           RootVolume:
             VolumeType: gp3

**Step 3e: Create the Cluster**

When you are ready, run the :command:`pcluster create-cluster` command.

.. code-block:: console

   $ pcluster create-cluster --cluster-name pcluster --cluster-configuration cluster-config.yaml

It may take several minutes up to an hour for your cluster's status to change to :literal:`CREATE_COMPLETE`.
You can check the status of you cluster with the following command.

.. code-block:: console

   $ pcluster describe-cluster --cluster-name pcluster

Once your cluster's status is :literal:`CREATE_COMPLETE`, run the :command:`pcluster ssh` command to ssh into it.

.. code-block:: console

   $ pcluster ssh --cluster-name pcluster -i ~/path/to/keyfile.pem


At this point, your cluster is set up and you can use it like any other HPC.
Now you can create a run directory by running the :literal:`createRunDir.sh` command. Your next steps will be following the normal instructions found in the User Guide.

.. _running_gchp_on_parallelcluster:

4. Running GCHP on ParallelCluster
----------------------------------

AWS ParallelCluster supports various job schedulers, and your cluster is configured to use **Slurm**. 

Generally, you do not need root privileges to submit or manage your own jobs. You can submit your run script using the standard ``sbatch`` command. 
However, if you need to perform administrative tasks (such as restarting the Slurm daemon), you can start a superuser shell by running ``sudo -s``.

For comprehensive instructions on configuring and running the model, please follow the official guide: :ref:`Running GCHP <gchp:running_gchp>`. 

Below are two scripts you can use to run GCHP on AWS. The first **gchp_aws_run.sh** is the main Slurm submission script, and the second **execute.sh** is a wrapper script executed on each compute node.

.. code-block:: bash
   :caption: gchp_aws_run.sh

   #!/bin/bash
   #
   #SBATCH --ntasks-per-node <core-per-node>
   #SBATCH -N <node-number>
   #SBATCH -t <HH-MM-SS>
   #SBATCH -p <queue-name>
   #SBATCH --job-name=<job-name>

   #################################################################
   #
   # ADDITIONAL PRE-RUN CONFIGURATION
   #
   # If a subsequent command fails, treat it as fatal (don't continue)
   set -e

   # Alternatively you can put this in your environment file.
   ulimit -c 0                  # coredumpsize
   ulimit -l unlimited          # memorylocked
   ulimit -u 50000              # maxproc
   ulimit -v unlimited          # vmemoryuse
   ulimit -s unlimited          # stacksize
   
   #################################################################
   #
   # PRE-RUN COMMANDS
   # You need to build your gchp environment using spack
   spack env activate gchp

   # For remainder of script, echo commands to the job's log file
   set -x

   # Define log name to include simulation start date
   start_str=$(sed 's/ /_/g' cap_restart)
   log=gchp.${start_str:0:13}z.log

   # Update config files, set restart symlink, and do sanity checks
   source setCommonRunSettings.sh
   source setRestartLink.sh
   source checkRunSettings.sh

   # OpenMPI networking optimizations for AWS
   export OMPI_MCA_btl=^ofi
   export OMPI_MCA_btl_tcp_if_exclude="lo,docker0,virbr0"
   export OMPI_MCA_btl_if_exclude="lo,docker0,virbr0"

   mpirun --map-by core --bind-to core -np ${SLURM_NTASKS} ./execute.sh &> ${log}

   #################################################################
   #
   # POST-RUN COMMANDS
   #
   # (Optional) Uncomment the lines below to rename mid-run checkpoint files 
   # and manage restart symlinks after the run completes.

   # chkpnts=$(ls Restarts)
   # N=$(grep "CS_RES=" setCommonRunSettings.sh | cut -c 8- | xargs )
   # for chkpnt in ${chkpnts}
   # do
   #     if [[ "$chkpnt" == *"gcchem_internal_checkpoint."* ]]; then
   #        chkpnt_time=${chkpnt:27:13}
   #        if [[ "${chkpnt_time}" = "${start_str:0:13}" ]]; then
   #            rm ./Restarts/${chkpnt}
   #        else
   #            new_chkpnt=./Restarts/GEOSChem.Restart.${chkpnt_time}z.c${N}.nc4
   #            mv ./Restarts/${chkpnt} ${new_chkpnt}
   #        fi
   #     fi
   # done

   # # If new start time in cap_restart is okay, rename restart file
   # # and update restart symlink
   # new_start_str=$(sed 's/ /_/g' cap_restart)
   # if [[ "${new_start_str}" = "${start_str}" || "${new_start_str}" = "" ]]; then
   #     echo "ERROR: GCHP failed to run to completion. Check the log file for more information."
   #     rm -f Restarts/gcchem_internal_checkpoint
   #     exit 1
   # else
   #     mv Restarts/gcchem_internal_checkpoint Restarts/gcchem_internal_checkpoint.${new_start_str:0:13}z.nc4
   #     # source setRestartLink.sh
   # fi
   
   exit 0

* **Interface Exclusion:** ``OMPI_MCA_btl_tcp_if_exclude="lo,docker0,virbr0"`` prevents OpenMPI from attempting to route MPI traffic through local loopback or virtual docker interfaces. On AWS EC2 instances, failing to exclude these can cause the model to hang indefinitely during initialization.

.. code-block:: bash
   :caption: execute.sh

   #!/bin/bash

   if [[ $( cat /proc/sys/kernel/yama/ptrace_scope ) == "0" ]]; then
           echo "PTrace Correct for EFA"
   else
           echo "PTrace Override"
           sysctl -w kernel.yama.ptrace_scope=0
   fi

   # Execute gchp
   ./gchp



