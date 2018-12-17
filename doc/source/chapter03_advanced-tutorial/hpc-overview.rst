.. _hpc-overview-label:

Overview of HPC cluster options on AWS
======================================

For heavy-duty work, it might be useful to create HPC-cluster-like environment.

Why do you need an HPC cluster
------------------------------

Basic EC2 instances can already fulfill most of computing needs, as you've learned in the beginner tutorials. An "HPC cluster" just provides those additional functionalities:

- **Jobs scheduler**. On the cloud, the job scheduler is generally not for sharing resources between multiple users, since the entire server belongs to you. Instead, the scheduler is for **requesting new resources automatically**. Whenever you submit a new job by ``qsub`` or ``sbatch``, a new instance is automatically launched (with spot pricing if needed) to run that job, and gets automatically terminated after the job is finished.

* **Shared disk storage**. By default, an EBS data volume can only be attached to one EC2 instance at a time. It is also possible to share an EBS volume between instances using the `Network File System (NFS) <https://en.wikipedia.org/wiki/Network_File_System>`_, but doing that by hand is kind of complicated and tedious. Instead, HPC management tools (see the next section) can set up shared disks for you.

- **Cross-node MPI connection**. To run large-scale MPI jobs with hundreds and thousands of cores, you need to connect multiple EC2 instances (just like connecting multiple "nodes" on traditional clusters). This can be done by hand, but using existing HPC tools is much easier.

For most of daily computing workload, it doesn't actually worth the effort to set up clusters (also consider that all HPC management tools have some initial learning curves). Using the basic EC2 is often much easier and controllable. For a single simulation, the "c5.18xlarge" type with 36 CPU cores is already pretty decent. For a few simultaneous runs, just launch separate EC2 instances (pretty quick with AWSCLI) and duplicate input data (pretty quick with S3).

So, when do you actually need an HPC environment?

- You need to use hundreds of cores to run a single MPI job.
- You have tens or hundreds of jobs to submit, which is too inconvenient to do with basic EC2 instances.
- When you decide that AWS should be your major working environment (i.e. "all-in on cloud"). Then it worths the effort to really get familiar with one HPC management tool. (For occasional use, the basic EC2 is more convenient.)

In any case, understand basic AWS services and concepts (finish all the beginner tutorials) before trying HPC clusters. All cluster management tools introduced below do not perfectly abstract away the underlying low-level AWS services. You will find them quite difficult to use and customize if you are unfamiliar with basic AWS concepts. 

HPC cluster management tools
----------------------------

Many cloud-HPC tools have been developed, both commercial and open-source. Here only covers open-source tools.

AWS ParallelCluster
^^^^^^^^^^^^^^^^^^^

`AWS ParallelCluster <https://aws-parallelcluster.readthedocs.io/>`_ is a rebranding of the previous `CfnCluster <http://cfncluster.readthedocs.io>`_, developed directly by AWS. It feels the most "AWS native" among all the tools, and is updated fairly often. However, its documentation is still quite thin and the learning curve for domain scientists can be relatively steep.

AlcesFlight
^^^^^^^^^^^

`Alces Flight <https://alces-flight.com>`_ provides `free and open-source tools <http://docs.alces-flight.com/en/stable/overview/whatisit.html#how-much-does-it-cost>`_ for HPC cluster management on AWS as well as paid services for advanced tasks. The free one ("Community Version") is generally enough for common research workloads. AlcesFlight has a pretty decent, comprehensive `documentation <http://docs.alces-flight.com/en/stable/index.html>`_ which keeps in mind the fact that domain scientists have very limited IT knowledge. Their `quick start guide <http://docs.alces-flight.com/en/stable/launch-aws/launching_on_aws.html>`_ teaches you how to create an HPC cluster on AWS.

Their cluster environment contains many `pre-built software modules <http://docs.alces-flight.com/en/stable/apps/gridware.html>`_, but they are not necessarily up-to-date. Fortunately, they support `Docker container <http://docs.alces-flight.com/en/stable/apps/docker.html>`_ and `Singularity container <http://docs.alces-flight.com/en/stable/apps/singularity.html>`_ so you can :doc:`run the model inside containers <./container>`.

ElasticCluster
^^^^^^^^^^^^^^

`ElasticCluster <http://gc3-uzh-ch.github.io/elasticluster/>`_ is quite platform-agnostic as it can deploy clusters on AWS, Azure, and Google Cloud. It is designed for general cluster setup, not just for tightly-coupled MPI/HPC simulations. Its documentation on MPI environment is quite thin and the learning curve can be steep for domain scientists.

StarCluster
^^^^^^^^^^^

`StarCluster <http://star.mit.edu/cluster/>`_ is one of the earliest cloud-HPC tool. It dominated the majority of cloud-HPC applications including research papers in the early time. Unfortunately, its development has stalled after 2014, so I don't recommend using it now.
