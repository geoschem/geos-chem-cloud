Use containers for platform-independent deployment
==================================================

Containers and scientific reproducibility
-----------------------------------------

A large number of research papers `cannot be reproduced <https://www.nature.com/collections/prbfkwmwvz/>`_. Reproducing Earth science model simulations is particularly hard, due to the difficulty of getting adequate computing power, downloading model input data, and configuring software environment. The cloud helps a lot with all those problems, but is still not ideal because you are essentially locked-in by a particular cloud vendor. We want to go one step further to make research projects reproducible everywhere. `Containers <https://en.wikipedia.org/wiki/Linux_containers>`_ can ensure exactly the same software environment everywhere, including your own machines, shared HPC clusters, and different cloud platforms. Thus you can easily combine cloud platforms with your already-invested local computing resources.

From a user's standpoint, a container behaves pretty much the same as a `virtual machine (VM) <https://en.wikipedia.org/wiki/Virtual_machine>`_ that incorporates the entire operating system and software libraries. While VMs can incur a significant performance penalty because a new operating system needs to run inside the existing system, containers run on the native operating system and have negligible performance overhead.

Once your machine has container software installed, you can further install any complicated models like `GCHP <http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_HP>`_ almost immediately. Single-node simulations are guaranteed to run correctly on different machines. (Multi-node MPI runs with containers are currently not very robust and might have system-specific issues.)

The container landscape
-----------------------

`Docker <https://www.docker.com>`_ is the most widely used container in the software world. The major use case is web applications but it is also used for scientific computing & data science (e.g. `Jupyter Docker stacks <https://github.com/jupyter/docker-stacks>`_, `Anaconda Docker image <https://github.com/ContinuumIO/docker-images>`_) and deep learning (e.g. `NVIDIA Docker <https://github.com/NVIDIA/nvidia-docker>`_). NCAR has a `Docker-WRF <https://ral.ucar.edu/projects/ncar-docker-wrf>`_ image which might be the easiest way to start WRF.

However, due to `security reasons <https://www.sherlock.stanford.edu/docs/software/using/singularity/#why-not-docker>`_, there is almost no chance to get Docker installed on shared HPC clusters. Many HPC-oriented containers have been developed to address Docker's limitations:

- The `Singularity <https://www.sylabs.io>`_ container, originally developed by Lawrence Berkeley National Lab, is by far the most popular "HPC container". It is installed on many university clusters, such as `Harvard's <https://www.rc.fas.harvard.edu/resources/documentation/software/singularity-on-odyssey/>`_ and `Stanford's <https://www.sherlock.stanford.edu/docs/software/using/singularity/>`_. Read this `Singularity article <http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0177459>`_ for more information.
- The `Charliecloud <https://hpc.github.io/charliecloud/>`_ container, developed by Los Alamos National Lab. It is available on `the NASA Pleiades cluster <https://www.nas.nasa.gov/hecc/support/kb/169/>`_.
- The `Shifter <https://docs.nersc.gov/development/shifter/overview/>`_ container, developed and used by `NERSC <http://www.nersc.gov>`_.
- `Inception <https://github.com/NCAR/Inception>`_, developed and used by NCAR.
- ...

More information can be found in the `containers in HPC symposium <https://sea.ucar.edu/conference/2018/containers>`_.

So which container to choose? If you own the machine and have root access, learning & using Docker is the safe bet. It is the industry standard has the widest applications. All the other containers are interoperable with Docker, and learning them will be straightforward if you already know Docker. One caveat is that domain scientists can find Docker not easy to learn, because its `official docs <https://docs.docker.com>`_ and most examples are about web apps, not scientific computing. `"Docker for data scientists" tutorials <https://towardsdatascience.com/how-docker-can-help-you-become-a-more-effective-data-scientist-7fc048ef91d5>`_ are generally much more accessible for domain scientists. Singularity is also a good alternative with a lighter learning curve, because it is designed for scientific uses.

On shared supercomputing clusters, it all depends on which container is available. Different containers largely follow the same Docker-like syntaxes and workflow, so don't worry about the divergence of software tools. If no containers are available on your cluster, you can `ask the cluster administrator <https://www.sylabs.io/guides/3.0/user-guide/installation.html#singularity-on-a-shared-resource>`_ to install Singularity for you. It is increasingly standard for shared HPC clusters to have some sort of containers installed.

Installing the container software
---------------------------------

Install on your own machine
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is system-specific so please refer to their official guides:

- `Installing Docker <https://docs.docker.com/install/>`_ (the Community Edition is perfectly enough)
- `Installing Singularity <https://www.sylabs.io/guides/3.0/user-guide/installation.html>`_
- `Installing CharlieCloud <https://hpc.github.io/charliecloud/install.html>`_

Installing the container might take some effort on some strange operating systems. But once it is correctly installed, it will resolve the `dependency hell <https://en.wikipedia.org/wiki/Dependency_hell>`_ for complicated Earth science models.

Testing pre-installed container on the cloud
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To test containers as quickly as possible, I recommend trying it on the cloud. The workflow on your local machine will be almost the same.

Launch an EC2 instance from ``ami-040f96ea8f5a0973e`` ( or ``container_geoschem_tutorial_20181213``). This AMI has Docker, Singularity, and CharlieCloud pre-installed. Use ``ec2-user`` as the login username. Use at least ``r5.2xlarge`` to provide enough memory for GCHP.

After login, you will find that this AMI has almost nothing installed besides the container software. It is based on AWS's specialized `Amazon Linux 2 AMI <https://aws.amazon.com/amazon-linux-2/>`_, which is very different from the Ubuntu operating system used in the our standard tutorial. We will use containers to provide exactly the same software environment and libraries used in standard tutorials.

Using GEOS-Chem container image
-------------------------------

The usage of different containers are highly similar, all covering 3 steps:

- Pull the container image -- it contains pre-configured model and all its software dependencies.
- Run the container -- it is like starting a subsystem where you can run the model. 
- Working with external files -- a container is isolated from the native system ("host system") by default. You would want to read input data from the native system and write output data back to the native system. The container itself should not contain very large data files.


Using Docker
^^^^^^^^^^^^

After login, you need to start the `"Docker daemon" <https://docs.docker.com/config/daemon/>`_ (i.e. background process) to support other Docker commands::

  sudo systemctl start docker

Starting the daemon requires root access. Other HPC containers (e.g. Singularity, CharlieCloud) don't need such as daemon process and don't require root access to run containers.

Pull GEOS-Chem Docker image from `Docker Hub <https://hub.docker.com/u/geoschem/>`_::

  docker pull geoschem/gc_model

Display current available images::

  docker images

Run the image::

  docker run --rm -it geoschem/gc_model /bin/bash

Those options are often used together with ``docker run``:

- ``-it`` (or ``-i -t`` ) and ``/bin/bash`` are for interactive bash environment. The ``/bin/bash`` can also be omitted for this image because it is set as default.
- ``--rm`` ensures that the container will be automatically deleted after exiting so you don't need extra ``docker rm ...`` command to remove it. 

Inside the container, it is like in a virtual machine that is isolated from the original system.

A pre-configured GEOS-Chem run directory is at ``/tutorial/geosfp_4x5_standard``. It will read input data from ``/ExtData`` and write output data to ``/OutputDir``. However, both directories are currently empty. We will need to point them to existing directory on the original system, so the container can interact with the outside.

Exit the container by ``Ctrl + d``. Rerun it with input and output directories mounted::

  docker run --rm -it -v $HOME/ExtData:/ExtData -v $HOME/OutputDir:/OutputDir  geoschem/gc_model /bin/bash

The ``-v`` option `mounts <https://en.wikipedia.org/wiki/Mount_(computing)>`_ a directory on the native system to a directory inside container. ``$HOME/ExtData`` and ``$HOME/OutputDir`` are where I store input and output data in the container tutorial AMI. **Change them accordingly on your own local machine**. Always use absolute path (displayed by ``pwd -P``) rather than relative path for mounting.

Inside the container, execute the model::

  cd /tutorial/geosfp_4x5_standard
  ./geos.mp

The default simulation will finish in a few minutes. Exist the container, check if output files reside in the native system's directory ``$HOME/OutputDir``.

Using Singularity
^^^^^^^^^^^^^^^^^

Pull GEOS-Chem image::

  singularity build --sandbox gc_model.sand docker://geoschem/gc_model

The ``--sandbox`` option allows the container to be modified. This is often required, unless you are not going to change any files and run-time configurations.

Run the container interactively::

  singularity shell --writable gc_model.sand

``--writable`` allows the changes you made in the container to persist after existing.

Exit the container by ``Ctrl + d`` because we haven't mount input/output directories. Similar to the Docker case, use ``-B`` to mount directories (equivalent to the ``-v`` option in Docker)::

  singularity shell --writable -B $HOME/ExtData:/ExtData -B $HOME/OutputDir:/OutputDir gc_model.sand

Singularity also mounts some commonly-used directories like $HOME and $PWD `by default <https://www.sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html#system-defined-bind-paths>`_.

Inside the container, execute the model::

  cd /tutorial/geosfp_4x5_standard
  ./geos.mp

.. warning::
  If the output files already exist in ``/OutputDir``, the current version of Singularity (3.0.1) will not overwrite them during model simulation, but will throw a permission error instead. Remove output files of the same name first.

Using CharlieCloud
^^^^^^^^^^^^^^^^^^

Pull GEOS-Chem image::

  ch-docker2tar geoschem/gc_model ./  # creates a compressed tar file
  ch-tar2dir geoschem.gc_model.tar.gz ./  # turn this tar file to a usable container image

``ch-docker2tar`` requires root access (it uses Docker under the hood). On a shared system like `NASA Pleiades <https://www.nas.nasa.gov/hecc/support/kb/creating-a-charliecloud-container-image-on-your-workstation-using-docker_560.html>`_, you need to transfer this tar file from the cloud and then use ``ch-tar2dir`` to decompress it.

Run the container without mounting any directories::

  ch-run -w geoschem.gc_model -- bash

The ``-w`` options gives write access in the container. This is usually required. ``bash`` starts a interactive bash shell, like the ``/bin/bash`` command in Docker.

Exit the container by ``Ctrl + d``, rerun the container with input/output directories mounted (the ``-b`` option is equivalent to the ``-v`` option in Docker)::

  ch-run -b $HOME/ExtData:/ExtData -b $HOME/OutputDir:/OutputDir -w geoschem.gc_model -- bash

Inside the container, execute the model::

  cd /tutorial/geosfp_4x5_standard
  ./geos.mp


Using custom GEOS-Chem source code
----------------------------------

The previous container image contains pre-compiled GEOS-Chem executable. Alternatively, containers can be used to only provide the software environment to compile custom versions of GEOS-Chem code.

::

  docker pull geoschem/gc_env
  <put your model code inside working_directory_on_host>
  docker run --rm -it -v working_directory_on_host:/workdir geoschem/gc_env
  cd /workdir  # will see your model code

Please refer to :ref:`the early chapter <custom-gc-label>` for setting up with custom configuration. Inside the container, the ``make`` command is guaranteed to work correctly because the libraries & environment variables are already configured properly.

Using GCHP container image
--------------------------

`GCHP <http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_HP>`_ is known to be difficult to compile because of heavy software dependencies. With containers, using GCHP is as easy as using the classic version of GEOS-Chem!

The usage of GCHP container is almost same as GC-classic container. Only the container image name is different.

With Docker::

  docker pull geoschem/gchp_model
  docker run --rm -it -v $HOME/ExtData:/ExtData -v $HOME/OutputDir:/OutputDir geoschem/gchp_model

Inside the container, execute the model::

  cd /tutorial/gchp_standard
  mpirun -np 6 -oversubscribe --allow-run-as-root ./geos

Similar for other containers:

Singularity::

  singularity build --sandbox gchp_model.sand docker://geoschem/gchp_model
  singularity shell --writable -B $HOME/ExtData:/ExtData -B $HOME/OutputDir:/OutputDir gchp_model.sand

CharlieCloud::

  ch‑docker2tar geoschem/gchp_model ./
  ch-tar2dir geoschem.gchp_model.tar.gz ~/
  ch-run -b $HOME/ExtData:/ExtData -b $HOME/OutputDir:/OutputDir -w geoschem.gchp_model -- bash

Inside the container, execute the model::

  cd /tutorial/gchp_standard
  mpirun -np 6 -oversubscribe ./geos

HPC containers do not require root access, unlike Docker.

Getting GEOS-Chem input data to your local machine
--------------------------------------------------

GEOS-Chem needs ~100 GB input data even for a minimum run. The container tutorial AMI provides those input data, but on your local machine you need to download them manually.

There are two ways of getting the data:

1. AWS S3: Simply running these `AWSCLI scripts <https://github.com/geoschem/geos-chem-cloud/tree/master/scripts/download_data/from_S3>`_ will download exactly the same set of GEOS-Chem input data used in our tutorial AMI. You need to first :doc:`configure AWSCLI <../chapter02_beginner-tutorial/awscli-config>` **on your local machine** in order to run the scripts. You will be charged by ~$10 data egress for downloading ~100 GB of sample input data to your local machine (no charge for downloading to an AWS EC2 instance). This is one-time charge and you will be all-set forever. We hope to establish a better business model with AWS in the future.

2. `Harvard FTP <http://wiki.seas.harvard.edu/geos-chem/index.php/Downloading_GEOS-Chem_source_code_and_data>`_: This is the traditional way. The bandwidth is not as great as S3 but there is no charge on users.

In our tests, transferring data from S3 is typically ~10x faster than transferring from traditional FTP (e.g. to the NASA Pleiades cluster). But this depends on the network of users' own servers.
