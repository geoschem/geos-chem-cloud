.. _hpc-overview-label:

Overview of HPC cluster options on AWS
======================================

For heavy-duty work, it might be useful to create HPC-cluster-like environment.

Why do you need an HPC cluster
------------------------------

Basic EC2 instances can already fulfill most of computing needs, as you've learned in the beginner tutorials. An "HPC cluster" just provides those additional functionalities:

- **Jobs scheduler**. On the cloud, the job scheduler is generally not for sharing resources between multiple users, since the entire server belongs to you. Instead, the scheduler is for **requesting new resources automatically**. Whenever your submit a new job by ``qsub`` or ``sbatch``, a new instance is automatically launched (with spot pricing if needed) to run that job, and gets automatically terminated after the job is finished.

* **Shared disk storage**. By default, an EBS data volume can only be attached to one EC2 instance at a time. It also is possible share an EBS volume between instances using the `Network File System (NFS) <https://en.wikipedia.org/wiki/Network_File_System>`_, but doing that by hand is kind of complicated and tedious. Instead, HPC management tools (see the next section) can set up shared disks for you.

- **Cross-node MPI connection**. To run large-scale MPI jobs with hundreds and thousands of cores, you need to connect multiple EC2 instances (just like connecting multiple "nodes" on traditional clusters). This can be done by hand, but using existing HPC tools is much easier.

For most of daily computing workload, it doesn't actually worth the effort to set up clusters (also consider that all HPC management tools have some initial learning curves). Using the basic EC2 is often much easier and controllable. For less than 5 simultaneous runs, just launch separate EC2 instances (pretty quick with AWSCLI) and duplicate input data (pretty quick with S3). For a single, big simulation, the "c5.18xlarge" type with 72 cores is already pretty decent. You can even run 4 simulations, each with 18 cores, on this 72-core server (just make sure that ``OMP_NUM_THREADS`` times the number of simultaneous runs do not exceed the total number of cores, otherwise all jobs will be desperately slow.).

So, when do you actually need an HPC environment?

- You need to use hundreds of cores to run a single MPI job.
- You have tens or hundreds of jobs to submit, which is too inconvenient to do with basic EC2 instances.
- When you decide that AWS should be your major working environment (i.e. "all-in on cloud"). Then it worths the effort to really get familiar with one HPC management tool. (For occassional use, the basic EC2 is more convenient.)

In any case, understand basic AWS services and concepts (finish all the beginner tutorials) before trying HPC clusters.

.. warning::
  **The major caveat of HPC clusters on cloud:** Those "clusters" are built upon tons of different AWS services to behave like a traditional cluster. The underlying AWS services are abstracted away and not directly exposed to users. However, `all abstractions are leaky <https://en.wikipedia.org/wiki/Leaky_abstraction>`_. If the cluster just works as you expected, then everything is fine. However, if you encounter a bug, the solution would generally require a fix of the underlying AWS services which you might have no idea about. That's another reason why I recommend really getting used to basic AWS services before trying clusters.

HPC cluster management tools
----------------------------

Many cloud-HPC tools have been developed over the past 10+ years, but only a few have relatively large communities. They are introduced below. I personally recommend AlcesFlight, according to the current development status of these tools.

CfnCluster
^^^^^^^^^^

`CfnCluster <http://cfncluster.readthedocs.io>`_ is an `open-source tool <https://github.com/awslabs/cfncluster/blob/develop/LICENSE.txt>`_ developed directly by AWS. The full name "cloud formation cluster" comes from the `Cloud​Formation service <https://aws.amazon.com/cloudformation/>`_, which is for combining different AWS resources together. Understanding CloudFormation is far beyond the IT knowledge of domain scientists. Fortunately, you can just use CfnCluster with terminal commands ``cfncluster xxx`` and don't have to understand how CloudFormation works under the hood. Its official doc provides a `simple tutorial <http://cfncluster.readthedocs.io/en/latest/hello_world.html>`_ on running a 2-node MPI job.

However, CfnCluster is an not an official AWS service, as you cannot find it anywhere in the AWS console. Its documentaion is not as comprehensive as AlcesFlight (see below) and there is a lack of comprehensive instructions for new users.

AlcesFlight
^^^^^^^^^^^

`Alces Flight <https://alces-flight.com>`_ provides `free and open-source tools <http://docs.alces-flight.com/en/stable/overview/whatisit.html#how-much-does-it-cost>`_ for HPC cluster management on AWS as well as paid services for advanced tasks. The free one ("Community Version") is generally enough for common research workloads. Alces Flight has a pretty decent, comprehensive `documentation <http://docs.alces-flight.com/en/stable/index.html>`_ which keeps in mind the fact that domain scientists have very limited IT knowledge. Their `quick start guide <http://docs.alces-flight.com/en/stable/launch-aws/launching_on_aws.html>`_ teaches you how to create an HPC cluster.

Their cluster environment contains many `pre-built software modules <http://docs.alces-flight.com/en/stable/apps/gridware.html>`_, but they are not necessarily up-to-date. Fortunately, they `support Singularity container <http://docs.alces-flight.com/en/stable/apps/singularity.html>`_ so you can :doc:`run the model inside containers <./container>`.

StarCluster
^^^^^^^^^^^

`StarCluster <http://star.mit.edu/cluster/>`_ is one of the earliest cloud-HPC tool. It dominated the majority of cloud-HPC applications including research papers in the early time. Unfortunately, its development has stalled after 2014, so I don't recommend using it now.
