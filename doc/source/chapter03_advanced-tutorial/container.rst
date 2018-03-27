Use containers to enhance research reproducibility
==================================================

The reproducibility crisis in science
-------------------------------------

A large number of research papers `cannot be reproduced <https://www.nature.com/collections/prbfkwmwvz/>`_. Reproducing Earth science model simulations is particularly hard, due to the difficulty of getting adequate computing power, downloading model input data, and configuring software environment. The cloud :ref:`helps a lot with all those problems <motivation-label>`, but is still not ideal because you are essentially locked-in by AWS (or other cloud vendors). We want to go one step further to make research projects reproducible everywhere.

The container technology can ensure exactly the same software environment everywhere, including your own machines, shared HPC clusters, and different cloud platforms. Thus you can easily combine cloud platforms with your already-invested local computing resources.

What are containers and how can they help
-----------------------------------------

A brute-force way to get the same software environment on different computers is to use a `virtual machine (VM) <https://en.wikipedia.org/wiki/Virtual_machine>`_ to deliver the entire system. But VMs incur a significant performance penalty since a new operating system needs to run inside the existing system. A `container <https://en.wikipedia.org/wiki/Linux_containers>`_ behaves pretty much the same as a VM, while having almost no performance penalty. (Their underlying implementations are vastly different but that's out of scope here.)

`Docker <https://www.docker.com>`_ is the most widely used container in the software world. The major use case is web applications but it is also used for scientific computing & data science (e.g. `Anaconda Docker image <https://github.com/ContinuumIO/docker-images>`_) and deep learning (e.g. `NVIDIA Docker <https://github.com/NVIDIA/nvidia-docker>`_). NCAR has a `Docker-WRF <https://ral.ucar.edu/projects/ncar-docker-wrf>`_ image which might be the easiest way to start WRF.

However, Docker has many limitations for HPC workloads. Using Docker for cross-node MPI programs is possible but very tricky. Further, due to security reasons, there is almost no chance to get Docker installed on shared HPC clusters. Also, domain scientists might find Docker's workflow quite unintuitive because it is mainly designed for web apps, not for numerical computing.

The `Singularity <http://singularity.lbl.gov>`_ container, developed by Lawrence Berkeley National Lab, overcomes the above limitations of Docker. It is already installed on many shared HPC clusters `including Harvard's <https://www.rc.fas.harvard.edu/odyssey-3-the-next-generation/>`_. Because Singularity is designed for scientific use, its workflow feels much more intuitive for domain scientists. Thus we choose Singularity as the container environment to run GEOS-Chem.

For more information about containers, read this `Singularity article <http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0177459>`_.

Install Singularity container
-----------------------------

Follow the `official docs <http://singularity.lbl.gov/docs-installation>`_ for installation on different platforms. On our tutorial AMI (based on Ubuntu), the full commands are::
  
  sudo apt-get update && \
      sudo apt-get install \
      python \
      dh-autoreconf \
      build-essential

  git clone https://github.com/singularityware/singularity.git
  cd singularity
  ./autogen.sh
  ./configure --prefix=/usr/local --sysconfdir=/etc
  make
  sudo make install

We deliberately do not include pre-installed Singularity in the tutorial AMI, to let you go through the installation process on your own -- you will see that installation is very easy and quick. On your own machine, the installation process is the same, and you will be able to use exactly the same environment on your own machine as on the cloud. On shared HPC clusters, you need to `ask the cluster administrator <http://singularity.lbl.gov/install-request>`_ to install Singularity for you if it is not there already.

Do some basic tests like in the `official start guide <http://singularity.lbl.gov/quickstart>`_::

  $ which singularity
  /usr/local/bin/singularity
  $ singularity pull shub://vsoch/hello-world
  Progress |===================================| 100.0%
  Done. Container is at: /home/ubuntu/vsoch-hello-world-master-latest.simg
  $ ./vsoch-hello-world-master-latest.simg
  RaawwWWWWWRRRR!!


Run GEOS-Chem inside Singularity container
------------------------------------------

Pull the GEOS-Chem Singularity image and name it ``GEOS-Chem-env.simg`` (the default name is quite lengthy)::

  $ singularity pull --name GEOS-Chem-env.simg shub://JiaweiZhuang/Singularity_GC

Then just "go into the container" with interactive mode::

  $ singularity shell GEOS-Chem-env.simg

The effect is kind of similar to ``module load xxx`` on HPC clusters -- you load all the libraries needed for GEOS-Chem. Then, just compile and run the model as usual.

If you use :ref:`screen/tmux <keep-running-label>`, remember to start a new session **before** starting the container.

