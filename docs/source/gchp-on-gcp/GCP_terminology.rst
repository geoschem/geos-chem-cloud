.. _gcp-terminology:

==========================
Reference: GCP Terminology
==========================

A short glossary of Google Cloud terms used in this guide.
Equivalents to AWS terms (where relevant) are listed for readers
familiar with the AWS GEOS-Chem cloud guide.


.. _term-project:

Project
----------------------

What is a GCP Project?
^^^^^^^^^^^^^^^^^^^^^^

A **Project** is the top-level GCP container for all resources.
Every VM, disk, network, and IP belongs to exactly one project, and
billing accumulates per project. Each project is identified by a
globally unique **Project ID** (e.g., ``gchp-prod-414000``), which
is what every ``gcloud`` command uses.

*AWS equivalent: AWS Account.*


.. _term-compute-engine:

Compute Engine
----------------------

What is Compute Engine?
^^^^^^^^^^^^^^^^^^^^^^^

**Compute Engine** is GCP's virtual machine service. It hosts the
cluster's controller, login, and burst compute nodes. The two
machine types used in this guide are:

* ``c2-standard-60`` - Cascade Lake Xeon with 30 physical cores
  per VM (hyperthreading off). ~$2.48/hour. Good for C48-C90
  single-node baseline runs.

* ``h4d-standard-192`` - AMD EPYC Bergamo with **192 physical
  cores per VM** and Intel Falcon iRDMA support. ~$10/hour.
  Required for multi-node Falcon RDMA workloads.

*AWS equivalent: EC2.*


.. _term-cluster-toolkit:

Cluster Toolkit
----------------------

What is Cluster Toolkit?
^^^^^^^^^^^^^^^^^^^^^^^^

Google's open-source HPC cluster deployer (formerly called HPC
Toolkit). It reads a **blueprint** (YAML) and generates Terraform
code to provision a Slurm cluster on Compute Engine.

Why use Cluster Toolkit for GCHP?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **Reproducible**: the entire cluster (network, Filestore,
  partitions, login, controller) is described in one YAML file.

* **Slurm-integrated**: the toolkit configures Slurm-on-GCP, which
  handles the bursting of compute nodes from the cluster's pool of
  zero running nodes when ``sbatch`` is invoked, and shuts them
  down once they have been idle for ~5 minutes.

* **Cost-aware**: only the controller and login VMs are always
  on. Compute nodes incur charges only while a job is running.

*AWS equivalent: AWS ParallelCluster.*


.. _term-filestore:

Filestore
----------------------

What is Filestore?
^^^^^^^^^^^^^^^^^^

**Filestore** is GCP's managed NFS service. We use it for the
cluster's ``/shared`` mount holding the Spack stack, GCHP binary,
ExtData, and run directories.

The smallest BASIC_HDD volume is 1 TB, costing ~$6.67/day. This is
the dominant fixed-cost line for an idle GCHP cluster.

*AWS equivalent: FSx for Lustre or EFS.*


.. _term-slurm-gcp:

Slurm (and Slurm-GCP)
----------------------

What is Slurm?
^^^^^^^^^^^^^^

The standard HPC batch scheduler. Submitted via ``sbatch``,
monitored with ``squeue`` and ``sinfo``. Cluster Toolkit ships a
Slurm-GCP integration that handles burst node provisioning. When
you ``sbatch`` a job, Slurm-GCP boots the requested number of
compute VMs from a pool of cloud-burst nodes (about 90 s for an H4D
node), runs the job, then powers them down ~5 minutes after the
last job finishes.


.. _term-falcon-rdma:

Falcon RDMA
----------------------

What is Falcon RDMA?
^^^^^^^^^^^^^^^^^^^^

Intel's RDMA-over-Ethernet technology, exposed on H4D instances via
the ``irdma`` kernel module and a dedicated VPC subnet with a
``<zone>-vpc-falcon`` network profile. Gives multi-node MPI the
low-latency, zero-copy semantics of InfiniBand.

The supported zones (as of 2026-06) are ``asia-southeast1-a``,
``europe-west4-b``, ``us-central1-a``, ``us-central1-b``, and
``us-west4-a``. The current list can be queried with
``gcloud compute network-profiles list | grep falcon``.

Why Falcon RDMA matters for GCHP
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Multi-node MPI via TCP over gVNIC degrades sharply at higher core
counts because the kernel network stack adds latency and CPU
overhead. Falcon RDMA bypasses the kernel for inter-node
communication, restoring near-shared-memory performance across the
cluster. 

*AWS equivalent: EFA on c5n/hpc6id instances.*


.. _term-gvnic:

gVNIC
----------------------

What is gVNIC?
^^^^^^^^^^^^^^

Google Virtual NIC - the standard high-performance virtual NIC on
modern Compute Engine instances. Carries normal TCP/IP traffic
(including NFS to Filestore). On H4D nodes it serves as the primary
NIC alongside an IRDMA secondary NIC.


.. _term-irdma:

IRDMA NIC
----------------------

What is an IRDMA NIC?
^^^^^^^^^^^^^^^^^^^^^

The NIC type GCP uses for Falcon RDMA on H4D. Attached as a second
network interface on each H4D VM, on a Falcon-enabled VPC subnet.
The kernel-side driver is the ``irdma`` module (loaded automatically
at boot by the published GCHP image).


.. _term-image:

Image
----------------------

What is a GCP Image?
^^^^^^^^^^^^^^^^^^^^

A snapshot of a VM's boot disk that can be used to launch new VMs.
The ``gchp1470-full-v2`` image (this guide) has the kernel
modules, system packages, and first-boot scripts required to run
GCHP on H4D. See :ref:`falcon-rdma-image` for details.

*AWS equivalent: AMI.*


.. _term-vpc-gcp:

VPC
----------------------

What is a VPC on GCP?
^^^^^^^^^^^^^^^^^^^^^

Virtual Private Cloud - the networking layer that connects your
VMs. Cluster Toolkit creates a regional VPC for the cluster. Falcon
RDMA requires a second, zone-pinned VPC with a ``vpc-falcon``
network profile.


.. _term-quota-gcp:

Service Quota
----------------------

What is a Service Quota?
^^^^^^^^^^^^^^^^^^^^^^^^

A regional or global limit on how many of a particular resource
(CPUs, IP addresses, Filestore TB) you can create. Default quotas
on a fresh project are low; raise them via **IAM & Admin -> Quotas
& System Limits**.

*AWS equivalent: Service Quotas / vCPU limits.*


.. _term-iam-gcp:

IAM (Identity and Access Management) on GCP
-------------------------------------------

What is IAM on GCP?
^^^^^^^^^^^^^^^^^^^

Google's identity and authorization framework. IAM controls who
(users, groups, service accounts) can do what (compute.admin,
file.editor, etc.) to which resources. Permission grants are made
by binding a **role** (a named set of permissions) to a **principal**
(a user, group, or service account).

When you run ``terraform apply`` to deploy a cluster, your user
needs ``roles/compute.admin``, ``roles/file.editor``, and several
others - listed in :ref:`prepare-gcp-environment`.


.. _term-billing-export:

Billing Export to BigQuery
--------------------------

What is Billing Export to BigQuery?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A GCP feature that mirrors every billing event into a BigQuery
table for SQL analysis. The cleanest way to audit your spend by
service over arbitrary time ranges. Enable in **Billing -> Billing
export**.

After 24 hours, you can run queries like:

.. code-block:: sql

   SELECT service.description, sku.description, SUM(cost) AS usd
   FROM `<project>.billing.gcp_billing_export_*`
   WHERE invoice.month = FORMAT_DATE('%Y%m', CURRENT_DATE())
   GROUP BY 1, 2 ORDER BY usd DESC


.. _term-cloud-storage:

Cloud Storage
----------------------

What is Cloud Storage?
^^^^^^^^^^^^^^^^^^^^^^

GCP's object store. Useful for archiving simulation output before
tearing down the cluster (``terraform destroy``) so that destroying
Filestore does not lose your results.

*AWS equivalent: S3.*


.. _term-os-login:

OS Login
----------------------

What is OS Login?
^^^^^^^^^^^^^^^^^

Google's recommended SSH access mechanism. Instead of putting
public keys into instance metadata, OS Login lets users SSH with
their GCP IAM identity. The published ``gchp1470-full`` image
works with both approaches.


.. _term-dws-flex-start:

Dynamic Workload Scheduler (DWS) Flex Start
-------------------------------------------

What is DWS Flex Start?
^^^^^^^^^^^^^^^^^^^^^^^

A provisioning mode where you ask GCP to run a job "sometime in the
next N hours" instead of demanding the resource right now. The
scheduler queues your request and starts it when capacity is
available. Cheaper than reservations; the right choice for H4D runs
that hit ``ZONE_RESOURCE_POOL_EXHAUSTED`` stockouts.

Submit with ``--provisioning-model=FLEX_START`` on
``gcloud compute instances bulk create``.
