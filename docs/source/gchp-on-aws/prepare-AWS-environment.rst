.. _prepare-aws-environment:

###############
Quickstart I: Prepare Your AWS Environment
###############

GCHP simulations are highly computationally intensive and demand robust infrastructure. To achieve the multi-core processing and fast networking speeds required for efficient runs, 
we strongly recommend deploying GCHP on **AWS ParallelCluster**.
This quickstart aims to guide you through the necessary steps from the beginning to prepare your AWS environment before configuring (:ref:`AWS ParallelCluster <term-pcluster>`) for GCHP.
    
1. IAM Permissions for Cluster Creation
---------------------------------------

AWS ParallelCluster uses (:ref:`AWS CloudFormation <term-cloudformation>`) to automatically provision resources on your behalf, including VPCs, EC2 instances, and IAM roles. 
And We need to set up the necessary (:ref:`IAM permissions <term-iam>`) for this to work correctly.

How you set this up depends on whether you own the AWS account or are using an institution's account.

Scenario A: You Manage Your Own AWS Account
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you created the AWS account yourself (or have Root access), you should create a dedicated IAM user with Administrator access specifically for managing your clusters.

1. Log in to the `AWS Management Console <https://console.aws.amazon.com/iam/>`_ and navigate to the **IAM** dashboard.
2. In the left navigation pane, click **Users**, then click the **Create user** button.
3. Enter a username (e.g., ``gchp-cluster-admin``) and click **Next**.
4. In the Permissions options panel, select **Attach policies directly**.
5. In the search bar, type ``AdministratorAccess``. Check the box next to the **AdministratorAccess** managed policy and click **Next**, then **Create user**.
6. Once the user is created, click on their name in the Users list and navigate to the **Security credentials** tab.
7. Scroll down to **Access keys** and click **Create access key**. 
8. Select **Command Line Interface (CLI)**, finish the prompts, and safely copy your ``Access key ID`` and ``Secret access key``. You will use these during the ``aws configure`` step.

Scenario B: You Belong to a University or Corporate Account
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't have ``AdministratorAccess`` in your AWS account, you will need to work with your AWS administrator to ensure you have the necessary permissions to create and manage clusters.

Because ParallelCluster creates dynamic IAM roles and CloudFormation stacks, there is no single "ParallelCluster" checkbox your IT admin can tick. You will need to request a custom IAM policy.

You may send your administrator the following message:

*"I am deploying an HPC environment using AWS ParallelCluster v3. The CLI uses AWS CloudFormation to automatically provision VPCs, EC2 instances, Auto Scaling Groups, and S3 buckets. 
Crucially, it also provisions customized IAM Roles for the cluster's Head Node and Compute Nodes.* *I need my IAM user to be granted a policy that allows the following actions:*
  
  * ``cloudformation:*``
  * ``ec2:*``
  * ``s3:*``
  * ``iam:CreateRole``, ``iam:CreateInstanceProfile``, ``iam:AddRoleToInstanceProfile``
  * ``iam:AttachRolePolicy``, ``iam:PutRolePolicy``
  * ``iam:PassRole`` *(for the HeadNode and ComputeNode roles)*"

.. note::
   If your IT department strictly enforces "Least Privilege" and refuses to grant ``iam:CreateRole``, they will need to manually pre-create the Head Node and Compute Node IAM roles for you. 
   You can then reference those existing roles in your ``cluster-config.yaml`` file. Refer them to the official AWS documentation on `Using an existing IAM role <https://docs.aws.amazon.com/parallelcluster/latest/ug/iam-roles-in-parallelcluster-v3.html>`_ for details.

* **Recommended for Individuals:** If you manage your own AWS account, ensuring your IAM user has ``AdministratorAccess`` is the simplest path forward.
* **Restricted Environments:** If you are operating within a university or corporate AWS environment, you might not have the permissions to create a cluster yourself. You will need your AWS Administrator to attach the ``AWSParallelClusterAdmin`` managed policy to your user, along with permissions to pass and create IAM roles (``iam:CreateRole``, ``iam:PassRole``).

.. warning::
   The issue of missing Permissions could be discovered in a later stage. If you encounter a ``User is not authorized to perform: cloudformation:CreateStack`` error during cluster creation, your IAM user lacks the required authority.


2. AWS Service Quotas (vCPU Limits)
-----------------------------------

By default, AWS places strict limits on the number of virtual CPUs (vCPUs) a new account can run simultaneously to prevent accidental overspending. Because GCHP relies heavily on multi-core, compute-optimized instances (like the ``c5n`` family), the default AWS limit is rarely high enough to launch a full compute fleet. 

If you do not increase this quota beforehand, your cluster's Head Node will deploy successfully, but your Slurm jobs will silently fail to spin up compute nodes. (You will usually find an ``InsufficientInstanceCapacity`` or ``VcpuLimitExceeded`` error in your cluster logs).

**How to calculate what you need:**

AWS quotas are measured in **vCPUs**, not the number of EC2 instances. You need to calculate your total maximum vCPUs:

1. Find the vCPU count for your desired compute node (e.g., a single ``c5n.18xlarge`` has 72 vCPUs).
2. Multiply that by the maximum number of nodes you want your cluster to scale up to (e.g., 10 compute nodes × 72 vCPUs = 720 vCPUs).
3. Add the vCPUs for your Head Node (e.g., a ``c5n.large`` has 2 vCPUs).
4. *Total requested quota needed:* **722 vCPUs**.

**How to request a quota increase:**

1. Log in to the AWS Management Console and navigate to the `Service Quotas dashboard <https://console.aws.amazon.com/servicequotas/>`_.
2. In the left-hand navigation pane, click on **AWS services**, then select **Amazon Elastic Compute Cloud (Amazon EC2)**.
3. In the search bar, type ``Running On-Demand``. 
4. Find the quota category that matches your instance family. For ``c5n`` instances, you need to select **Running On-Demand Standard (A, C, D, H, I, M, R, T, Z) instances**.
5. Click on the quota name, then click the **Request quota increase** button on the right side of the screen.
6. Enter your calculated vCPU total as the new quota value and submit the request.

.. note::
   Quota increases can take 24-48 hours to be approved by AWS. If your cluster fails to spin up compute nodes and the logs show an ``InsufficientInstanceCapacity`` or ``VcpuLimitExceeded`` error, you need to increase this quota.

3. Node.js Backend Requirement
------------------------------

Starting with AWS ParallelCluster version 3, the ``pcluster`` command-line interface relies heavily on the AWS Cloud Development Kit (AWS CDK) to generate the CloudFormation templates that actually build your cluster. 
Because the AWS CDK is built on JavaScript, **Node.js is a strict prerequisite** for the local machine or environment where you intend to run the CLI.

Even though you will install ParallelCluster using Python's ``pip``, your cluster creation will fail immediately if Node.js is missing from your system.

**Install Node.js:**
The most reliable way to install Node.js on a Linux or macOS environment is by using the Node Version Manager (nvm) to install the latest Node.js version. 
Alternatively, you can download the installer directly from the `official Node.js website <https://nodejs.org/>`_. 

**Verifying your installation:**
Once you have installed Node.js, you should verify that your system's terminal recognizes the command. Open your terminal and run the following checks:

.. code-block:: bash

   $ node -v

You should see an output displaying the version number, such as ``v23.7.0``. 
