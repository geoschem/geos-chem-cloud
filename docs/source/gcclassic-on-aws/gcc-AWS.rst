.. _run-gcc-on-aws-ec2:

Run GC Classic on AWS EC2
==========================

GC Classic is an OpenMP application, meaning it runs on a single node. 
Therefore, you do not need a complex cluster scheduler (like AWS ParallelCluster). 
You can simply launch a single, powerful EC2 instance using our provided Amazon Machine Image (AMI).

**Available AMIs:**

=========================   ====================   ============    ===================    
AMI ID                      Name                   OS              architecture           
=========================   ====================   ============    ===================    
ami-096e8e151989dbfc5       GCC-12.3-GEOSChem      alinux2023      x86_64                
=========================   ====================   ============    ===================   

It contains a dedicated storage volume mounted at :literal:`/data` which contains the software environment for creating a GC Classic run directory and compiling the model. 

.. _launching_instance:

1. Launch your EC2 Instance
----------------------------

1. Log in to the **AWS Console** and navigate to **EC2**.

2. Click **Launch Instance**.

3. **Name**: Give your instance a name (e.g., "GCC14.7-Simulation").

4. **Application and OS Images (AMI)**: Search the AMI ID in Community AMIs. 

5. **Instance Type**: **Recommended**: :literal:`c5n.large` (2 vCPUs, 5.3 GiB RAM)

6. **Key Pair**: Select your SSH key pair. (Create a new .pem key pair if you don't have one.)

7. **Configure Security Group**: Ensure the security group allows SSH access (port 22) and any other required ports for your simulation (e.g., 80, 443).

8. **Configure storage**: 
    • You will see two volumes listed automatically (inherited from the AMI):

        a. **Root volume (30 GB)**: The operating system. Do not save simulation data here.

        b. **EBS volume (100 GB minimum)**: Mounted at :literal:`/data`. Use this directory for everything.

    • **Tip**: You should increase the size of the second volume (the :literal:`/data` volume) as you demand for your simulation.

9. **Launch the instance**. You should see your instance in the EC2 console with a status of "running".

.. _connecting_and_setup:

2. Connect and Storage Setup
--------------------------------

SSH into your instance:

.. code-block:: console

    $ ssh -i your-key.pem ec2-user@<instance-ip>

**Verify the Environment**. The spack environment named :literal:`gc-env` is configured to load automatically. You can verify the compiler is ready in the spack directory :literal:`/data/spack/opt/spack`:

.. code-block:: console

    $ which gfortran

3. Download Code and Data
---------------------------

Now you can download the GC Classic source code and data files to your instance's :literal:`/data` directory. You can follow :ref:`quick` to run GCClassic.

.. warning::

    **Do not use your home directory (~) for simulations**. The root disk is small (30 GB). Always work inside :literal:`/data`.

