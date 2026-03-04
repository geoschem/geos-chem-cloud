.. |br| raw:: html

   <br />

.. _run-gcc-on-aws-ec2:

################################
Run GEOS-Chem Classic on AWS EC2
################################

`GEOS-Chem Classic <https://geos-chem.readthedocs.io>`_  is an `OpenMP
<https://www.openmp.org/>`_ application, meaning it runs on a single
node. Therefore, you do not need a complex cluster scheduler (like AWS
ParallelCluster). You can simply launch a single, powerful EC2
instance using our provided Amazon Machine Image (AMI).

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

#. Log in to the **AWS Console** and navigate to **EC2**. |br|
   |br|

#. Click **Launch Instance**. |br|
   |br|

#. **Name**: Give your instance a unique name s (e.g.,
   :literal:`GCC14.7-Simulation`) so that you can easily identify it
   in the list of instances in the AWS Console. |br|
   |br|

#. **Application and OS Images (AMI)**: Search for the AMI ID from the
   table above in **Community AMIs**. |br|
   |br|

#. **Instance Type**: We recommend that you create a **Spot
   Instance** with one of the instance types listed below:

   .. list-table:: Recommended AWS EC2 instance types
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
   expensive to use.

   Spot instances cost less than **On-Demand Instances** (which have
   the highest priority), but may be pre-empted by an on-demand
   instance at any time. Nevertheless, we find that it is routinely
   possible to run GEOS-Chem simulations for several hours on a spot
   instance without the instance being terminated.

   Be sure to check the latest `pricing for spot instances
   <https://aws.amazon.com/ec2/spot/pricing/>`_ vs. `pricing for
   on-demand instances
   <https://aws.amazon.com/ec2/pricing/on-demand/>`_. |br|
   |br|


#. **Key Pair**: Select your SSH key pair or `create a new key pair
   <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html>`_
   if you don't have one.  The private key should end with the
   :file:`.pem` extension and be placed in your :file:`~/.ssh` folder.
   Make sure the private key is only readable by you (i.e. give it
   :literal:`chmod 600` permission. |br|
   |br|

#. **Configure Security Group**: Ensure the security group allows SSH
   access (port 22) and any other required ports for your simulation
   (e.g., 80, 443). |br|
   |br|

#. **Configure storage**:

   - You will see two volumes listed automatically (inherited from the
     AMI):

     - **Root volume (30 GB)**: The operating system. Do not save
	simulation data here.

     - **EBS volume (100 GB minimum)**: Mounted at
       :literal:`/data`. Use this directory for everything.

   - **Tip**: You should increase the size of the second volume (the
     :literal:`/data` volume) as you demand for your simulation.
     |br|

#. **Launch the instance**. You should see your instance in the EC2
   console with a status of "running".

.. _connecting_and_setup:

========================
Connect to your instance
========================

Connect to your instance via SSH:

.. code-block:: console

    $ ssh -YA -i ~/.ssh/your-private-key.pem ec2-user@<instance-ip>

You can get the :literal:<instance-ip>` from the AWS console.

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
