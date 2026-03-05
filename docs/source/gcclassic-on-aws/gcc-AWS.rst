.. |br| raw:: html

   <br />

.. _run-gcc-on-aws-ec2:

################################
Run GEOS-Chem Classic on AWS EC2
################################

`GEOS-Chem Classic <https://geos-chem.readthedocs.io>`_  is an `OpenMP
<https://www.openmp.org/>`_ application, meaning it runs on a single
node. Therefore, you do not need a complex cluster scheduler (like
:ref:`AWS ParallelCluster <using_aws_parallelcluster>`). You can
simply launch a single, powerful Elastic Cloud Compute (EC2) instance
using our provided  Amazon Machine Image (AMI).

.. list-table:: Available AMIs
   :align: center
   :header-rows: 1
   :widths: 30 30 20 20

   * - AMI ID
     - Name
     - OS
     - Architecture
   * - ami-096e8e151989dbfc5
     - GCC-12.3-GEOSChem
     - alinux2023
     - x86_64

The AMI contains a dedicated storage volume mounted at
:literal:`/data` which contains the software environment for creating
a GEOS-Chem Classic run directory and compiling the model.

.. _launching_instance:

========================
Launch your EC2 instance
========================

#. Log in to the **AWS Console** and navigate to `EC2
   <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/console.html>`_. |br|
   |br|

#. Click **Launch Instance**.
   |br|
   |br|

#. Give your instance a **unique name** (e.g.,
   :literal:`GCC14.7-Simulation`) so that you can easily identify it
   in the list of instances in the EC2 Console. |br|
   |br|

#. Look under **Application and OS Images (AMI)** and search for the
   AMI ID listed above in **Community AMIs**. |br|
   |br|

#. We recommend that you create a **Spot Instance** with one of the
   **instance types**  listed below:

   .. list-table:: Suggested AWS EC2 instance types
      :align: center
      :header-rows: 1

      * - Specification
        - c5.12xlarge
	- c7i.16xlarge
      * - Generation
        - 5th gen (2018)
	- 7th gen (2023)
      * - vCPUs
        - 48
        - 64
      * - Memory (GiB)
        - 96
        - 128
      * - Processor
        - Xeon Platinum 8k
	- Xeon Scalable 4G
      * - Network (Gbps)
	- 12
        - 25
      * - Network bandwidth (Mbps)
        - 9,500
        - 20,000

   The price of a spot instance (per hour) depends on the instance
   type that is selected.  For example, the :literal:`c7i.16xlarge`
   instance type has more memory and double the network speed of the
   :literal:`c5.12xlarge` instance type, and thus will be more
   expensive to use.  You may, of course, select another instance type
   that is more cost-effective for your situation.  But the two listed
   above have proven to be very sufficient for running GEOS-Chem
   simulations.

   Spot instances cost less than **On-Demand Instances**, which are
   guaranteed to execute with the highest priority.  Spot instances
   may therefore be pre-empted by an on-demand instance at any
   time. Nevertheless, we find that we can routinely run GEOS-Chem
   simulations for several hours on a spot instance without the
   instance being pre-empted.

   Be sure to check the latest `pricing for spot instances
   <https://aws.amazon.com/ec2/spot/pricing/>`_ vs. `pricing for
   on-demand instances
   <https://aws.amazon.com/ec2/pricing/on-demand/>`_ for each instance
   type.  This information changes frequently, so be sure to check
   back periodically. |br|
   |br|


#. Select your **SSH key pair** or `create a new key pair
   <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html>`_
   if you don't have one.  The private key should end with the
   :file:`.pem` extension and be placed in your :file:`~/.ssh` folder.
   Make sure the private key is only readable by you (i.e. give it
   :literal:`chmod 600` permission. |br|
   |br|

#. Ensure that your `security group
   <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-security-groups.html>`_
   allows SSH access (port 22) and any other required ports for your
   simulation (e.g., 80, 443). |br|
   |br|

#. **Configure storage**:

   - You will see two volumes listed automatically (inherited from the
     AMI):

     - **Root volume (30 GB)**: The operating system. Do not save
       simulation data here.

     - **Elastic Block Storage (EBS) volume (100 GB minimum)**: Mounted at
       :literal:`/data`. Use this directory for everything.

   .. tip::

      You should increase the size of the :literal:`/data` volume as
      accordingly for your simulation.

#. `Launch your EC2 instance
   <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/launching-instance.html>`_.
   You should see your instance listed in the EC2 Console with a
   status of "Running".

.. _connecting_and_setup:

========================
Connect to your instance
========================

Connect to your instance via SSH:

.. code-block:: console

    $ ssh -YA -i ~/.ssh/your-private-key.pem ec2-user@<instance-ip>

You can get the :literal:<instance-ip>` from the EC2 Console.

======================
Verify the environment
======================

The Spack environment named :literal:`gc-env` is configured to load
automatically. You can verify the compiler is ready in the spack directory
:file:`/data/spack/opt/spack`:

.. code-block:: console

    $ which gfortran

============================================
Download the GC-Classic source code and data
============================================

Follow the instructions
in the `GEOS-Chem Classic Quickstart Guide
<https://geos-chem.readthedocs.io/en/stable/getting-started/quick-start.html>`_
to download the GEOS-Chem Classic source code and input data to your
instance's :literal:`/data` directory.

.. warning::

    **Do not use your home directory (~) for simulations**. The root
    disk is small (30 GB). Always work inside :literal:`/data`.
