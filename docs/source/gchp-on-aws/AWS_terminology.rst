==========================
AWS Reference: AWS Terminology
==========================

.. _term-pcluster:

AWS ParallelCluster
----------------------

What is AWS ParallelCluster?
^^^^^^^^^^^^^^^^^^^^^^^^

AWS ParallelCluster is a cloud cluster management tool that simplifies the deployment and management of High-Performance Computing (HPC) clusters. It automates the provisioning of resources, configuration of cluster software, and management of cluster lifecycle. 
An AWS ParallelCluster environment consists of a head node, a dynamic compute fleet of EC2 instances that spin up only when tasks are running, and a shared high-performance file system.

Why Use AWS ParallelCluster for GCHP?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

GCHP simulations require plenty of computational resources, low-latency MPI communication, and high-speed storage. ParallelCluster provides some major advantages for this workflow:

* **Scalability:** Easily configure your compute resources up or down based on your simulation needs. 
* **Cost Efficiency:** With ParallelCluster's dynamic compute fleet, you only pay for the compute resources when they are actively running jobs. When your cluster is idle, you are not charged for compute resources.
* **Customizability:** ParallelCluster allows you to customize your cluster configuration, including instance types, storage options, and network settings. This flexibility enables you to optimize your cluster for GCHP's specific requirements, such as using compute-optimized instances and high-performance file systems.
* **Integration with AWS Services:** ParallelCluster integrates seamlessly with other AWS services, such as FSx for Lustre for shared file systems and CloudWatch for monitoring. 
This integration allows you to easily manage your GCHP simulations and access your results.

How AWS ParallelCluster Works
^^^^^^^^^^^^^^^^^^^^^^^^

The AWS ParallelCluster operates using three main components:

1. **Head Node:** This is the central management node of your cluster. It installs your AMI libraries and dependencies (if using a custom AMI) and serves as the entry point when you SSH into your cluster. 
The head node also manages job scheduling and resource allocation for the compute nodes.

2. **Compute Nodes:** These are the worker nodes that perform the actual computations for your GCHP simulations. 
They are dynamically provisioned based on the workload and can be configured to use specific instance types optimized for HPC workloads.

3. **Shared File System:** This is a high-performance storage that allows all nodes in the cluster to access the same data. This is where you will download GCHP input data, compile the model, and configure your run directories. 
AWS ParallelCluster supports various shared file system options, such as Amazon FSx for Lustre, which is ideal for HPC workloads.

.. _term-cloudformation:
AWS CloudFormation
----------------------

What is AWS CloudFormation?
^^^^^^^^^^^^^^^^^^^^^^^
AWS CloudFormation is a service that allows you to define and provision AWS infrastructure using code. You can create templates that describe the resources you want (like EC2 instances, VPCs, IAM roles, etc.) 
and CloudFormation will take care of provisioning and configuring those resources for you. This is particularly useful for managing HPC clusters.

AWS ParallelCluster uses AWS CloudFormation to automate the provisioning of resources. When you create a cluster, ParallelCluster generates a CloudFormation template that defines the infrastructure and configuration of your cluster. 
This template is then deployed to AWS, which creates the necessary resources (VPCs, EC2 instances, IAM roles, etc.) based on the specifications in the template. 

Checking Cluster Status and Troubleshooting
^^^^^^^^^^^^^^^^^^^^^^^
Because ParallelCluster relies entirely on CloudFormation to build your environment, the AWS CloudFormation Console is the best place to check your cluster's deployment status or troubleshoot errors. 

If your ``pcluster create-cluster`` command fails, the CLI will usually provide a general error message. To find the exact underlying cause:


1. Log in to the AWS Management Console and navigate to the **CloudFormation** service.
2. Under **Stacks**, look for a stack that matches the name of your cluster.
3. Click on the stack name and navigate to the **Events** tab.
4. Here, you will see a chronological log of every resource AWS attempted to create. Look for any events marked ``CREATE_FAILED`` in red. 
5. The **Status reason** column will usually tell you exactly what went wrong (e.g., a missing IAM permission, an invalid subnet ID, or hitting a vCPU quota limit).

.. note::
   If a critical error occurs during cluster creation, CloudFormation will automatically trigger a ``ROLLBACK_IN_PROGRESS`` status. 
   This means AWS is deleting the partially built cluster to prevent you from being charged for a broken environment. 
   You must wait for the rollback to reach ``ROLLBACK_COMPLETE`` before attempting to recreate the cluster with the same name.


.. _term-iam:

IAM (Identity and Access Management)
----------------------

**AWS Identity and Access Management (IAM)** is the security framework that controls who can access which AWS services and resources. It works by assigning specific "Policies" (lists of allowed actions) to "Identities" (like Users or Roles). 



In the context of AWS ParallelCluster and GCHP, IAM permissions operate at two completely different levels:

1. Your IAM User Permissions (The Builder)
^^^^^^^^^^^^^^^^^^^^^^^
This is the identity you use when you configure the AWS CLI and run the ``pcluster create-cluster`` command. In order to build the cluster on your behalf, your IAM user needs broad permissions. 

You must have the authority to provision VPCs, launch EC2 instances, use CloudFormation, and—crucially—create and pass *new* IAM roles to the cluster. If your university or corporate IT department restricts your ability to create IAM roles, your cluster creation will fail.

2. The Cluster's IAM Roles (The Operators)
^^^^^^^^^^^^^^^^^^^^^^^
Once the cluster is built, the EC2 instances themselves need permission to communicate with other AWS services. Instead of using a username and password, AWS assigns an **IAM Role** directly to the Head Node and the Compute Fleet.

* **The Head Node Role:** Needs permission to monitor the Slurm queue and tell AWS to spin up new compute nodes when you submit a job.
* **The Compute Node Role:** Needs permission to write system logs to Amazon CloudWatch so you can troubleshoot failed runs.

.. note::
   If you do not have permission to create IAM roles yourself, your AWS Administrator can pre-create the Head Node and Compute Node roles for you. You can then specify these pre-existing roles in your ``cluster-config.yaml`` file under the ``Iam`` section.


.. _term-fsx-lustre:

Amazon FSx for Lustre
----------------------

**Amazon FSx for Lustre** is a fully managed, high-performance file system optimized for compute-intensive workloads. "Lustre" is a popular open-source parallel file system used by many of the world's largest supercomputers. 



How FSx for Lustre is Used in AWS ParallelCluster
^^^^^^^^^^^^^^^^^^^^^^^

When you run a GCHP simulation on ParallelCluster, your Head Node and all of your dynamic Compute Nodes need to access the exact same files at the exact same time. 

If you define an FSx for Lustre file system in your cluster configuration (or mount an existing one), ParallelCluster automatically attaches this shared drive to every node in your cluster. 
When your compute instances spin up to process a Slurm job, they instantly have read and write access to your GEOS-Chem run directories, input data catalogs, and output folders.

Benefits for GCHP Users
^^^^^^^^^^^^^^^^^^^^^^^

GCHP is I/O (Input/Output) intensive. In the cloud, storage speed is just as important as CPU power. 

* **High Throughput for Meteorological Data:** GCHP constantly reads massive, high-resolution meteorological fields and emissions data. Standard cloud storage (like Amazon EFS or basic EBS volumes) can severely bottleneck the simulation, causing your expensive CPUs to sit idle while waiting for data. FSx for Lustre provides the massive throughput and sub-millisecond latencies required to keep the model running efficiently.
* **Parallel Writing:** When GCHP outputs History diagnostics into netCDF files, multiple MPI processes across different nodes often need to write data simultaneously. A parallel file system like Lustre is specifically engineered to handle these parallel write operations without data corruption or massive slowdowns.
* **Seamless S3 Integration:** You can link an FSx for Lustre file system directly to an Amazon S3 bucket. If you have a massive archive of GEOS-Chem input data stored cheaply in S3, FSx can "lazy-load" the files. They will appear as regular files on your cluster's hard drive, but the data is only downloaded from S3 the very first time GCHP actually attempts to read it.

.. note::
   **Cost Management:** FSx for Lustre provides supercomputer-level performance, but it can be expensive. Because the data is stored on persistent high-speed drives, you pay an hourly rate for the total storage capacity as long as the file system exists—even if your ParallelCluster compute nodes are powered down and the queue is empty.