.. |br| raw:: html

   <br />

.. _prepare-gcp-environment:

##########################################
Quickstart I: Prepare Your GCP Environment
##########################################

GCHP simulations are highly computationally intensive and demand
robust infrastructure. To achieve the multi-core processing and fast
networking speeds required for efficient runs, we strongly recommend
deploying GCHP on a Slurm-managed HPC cluster built with Google's
`Cluster Toolkit <https://github.com/GoogleCloudPlatform/cluster-toolkit>`_.

This quickstart guides you through the necessary steps from the
beginning to prepare your Google Cloud Platform (GCP) environment
before configuring :ref:`Cluster Toolkit <term-cluster-toolkit>` for
GCHP. None of the steps below incur compute charges by themselves,
but several of them (especially quota increases) can take **24-48
hours**, so do them well before you plan to run jobs.

.. warning::
   Quota increases for H4D and large CPU pools can take 24-48 hours
   to be approved by Google Cloud Support. If your cluster fails to
   spin up compute nodes and the logs show a
   ``ZONE_RESOURCE_POOL_EXHAUSTED`` or ``QUOTA_EXCEEDED`` error, you
   need to request more quota in **IAM & Admin -> Quotas & System
   Limits** in the Google Cloud Console.


================================================================================
1. Create a GCP Project and Link Billing
================================================================================

A :ref:`Project <term-project>` is the top-level container for all
GCP resources. Every VM, disk, and IP address belongs to exactly one
project, and billing is tracked per project.

1. Sign in at https://console.cloud.google.com.

2. Open the project selector (top bar) -> **NEW PROJECT**.

3. Give the project a name like ``gchp-prod`` and note the assigned
   **Project ID** (e.g., ``gchp-prod-414000``). The Project ID, not
   the project name, is what every ``gcloud`` command uses.

4. Open **Billing** in the left navigation. Link an active billing
   account to the new project. New accounts receive a $300 free
   credit valid for 90 days, which is useful for the initial cluster
   bring-up.

.. tip::
   To watch your spend in real time, enable **Billing export to
   BigQuery** under *Billing -> Billing export*. After approximately
   24 hours of data, you can query exact daily spend per SKU with
   SQL. See :ref:`set-up-gcp-cluster` for the example query.


================================================================================
2. IAM Permissions for Cluster Creation
================================================================================

Cluster Toolkit uses `Terraform <https://www.terraform.io/>`_ to
provision resources on your behalf, including VPCs, Compute Engine
instances, Filestore volumes, and :ref:`IAM <term-iam-gcp>` service
accounts. The user who runs ``gcluster create`` must have permission
to create all of those.

The simplest setup is to give your user the **Owner** role on the
project during initial bring-up, then narrow to per-resource roles
afterward. For a least-privilege configuration, the user needs the
following IAM roles:

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Role
     - Purpose
   * - ``roles/compute.admin``
     - Create VMs, disks, images, networks, subnets
   * - ``roles/file.editor``
     - Create and manage Filestore NFS volumes
   * - ``roles/iam.serviceAccountAdmin``
     - Create the cluster's service account
   * - ``roles/iam.serviceAccountUser``
     - Attach service accounts to VMs
   * - ``roles/resourcemanager.projectIamAdmin``
     - Bind service accounts to roles
   * - ``roles/storage.admin``
     - Read/write to Cloud Storage if used

Apply them with:

.. code-block:: bash

   PROJECT_ID="<your-project-id>"
   USER_EMAIL="<your-google-account@example.com>"
   for ROLE in compute.admin file.editor iam.serviceAccountAdmin \
               iam.serviceAccountUser resourcemanager.projectIamAdmin \
               storage.admin; do
       gcloud projects add-iam-policy-binding "$PROJECT_ID" \
           --member="user:$USER_EMAIL" \
           --role="roles/$ROLE"
   done

.. warning::
   The issue of missing permissions could be discovered in a later
   stage. If you encounter an error such as
   ``Permission 'compute.networks.create' denied`` during cluster
   creation, your IAM user lacks the required authority. Re-run the
   binding above, or temporarily switch to the **Owner** role until
   you finish the initial setup.


================================================================================
3. Enable Required APIs
================================================================================

On a fresh project, most GCP APIs are disabled by default. Enable
the ones GCHP needs:

.. code-block:: bash

   gcloud config set project "$PROJECT_ID"
   for API in compute.googleapis.com \
              file.googleapis.com \
              cloudresourcemanager.googleapis.com \
              servicenetworking.googleapis.com \
              storage.googleapis.com \
              cloudbilling.googleapis.com \
              deploymentmanager.googleapis.com \
              iam.googleapis.com; do
       gcloud services enable "$API"
   done

Enabling each API takes about 30 seconds. Cluster Toolkit will
refuse to create the cluster until all of these are active.


================================================================================
4. GCP Service Quotas (vCPU, H4D, Filestore)
================================================================================

Fresh GCP projects have very low default quotas, usually not enough
to run GCHP at production scale. Request increases at least one
week before you plan to run.

Open **IAM & Admin -> Quotas & System Limits** in the Cloud Console,
filter by quota name, and request the values below for your target
region (the rest of this guide uses ``us-central1``):

.. list-table::
   :header-rows: 1
   :widths: 32 14 35 19

   * - Quota name
     - Region
     - Why
     - Suggested
   * - ``CPUs (all regions)``
     - us-central1
     - Total cluster cores
     - >= 500
   * - ``C2 CPUs``
     - us-central1
     - c2-standard-60 burst capacity
     - >= 240
   * - ``H4D CPUs``
     - us-central1
     - h4d-standard-192 (1 node = 192 cores)
     - >= 384 (2 nodes)
   * - ``In-use IP addresses``
     - us-central1
     - NAT + RDMA per-node IPs
     - >= 16
   * - ``Persistent Disk SSD (GB)``
     - us-central1
     - Controller + login boot disks
     - >= 500
   * - ``Filestore Basic HDD storage (TB)``
     - us-central1
     - NFS for ``/shared``
     - >= 2

.. note::
   H4D and Falcon RDMA capacity is offered only in specific zones:
   ``asia-southeast1-a``, ``europe-west4-b``, ``us-central1-a``,
   ``us-central1-b``, and ``us-west4-a`` as of 2026-06. Verify
   available zones with the following command before requesting H4D
   quota:

   .. code-block:: bash

      gcloud compute machine-types list --filter="name=h4d-standard-192" \
          --format="value(zone)"


================================================================================
5. Install gcloud, Terraform, and Cluster Toolkit
================================================================================

Install the three tools on your **local workstation** (not on a
cloud VM):

5a. Install gcloud CLI
--------------------------------------------------------------------------------

.. code-block:: bash

   curl https://sdk.cloud.google.com | bash
   exec -l $SHELL
   gcloud init                                # picks the project + login
   gcloud auth application-default login      # for Terraform

5b. Install Terraform 1.7+
--------------------------------------------------------------------------------

.. code-block:: bash

   brew install terraform        # macOS
   # or:
   apt-get install terraform     # Debian/Ubuntu

5c. Install Cluster Toolkit
--------------------------------------------------------------------------------

.. code-block:: bash

   git clone https://github.com/GoogleCloudPlatform/cluster-toolkit.git \
       ~/cluster-toolkit
   cd ~/cluster-toolkit
   make

Verify all three:

.. code-block:: bash

   $ gcloud --version
   Google Cloud SDK 530.0.0
   ...
   $ terraform --version
   Terraform v1.10.5
   $ ~/cluster-toolkit/gcluster --version
   gcluster v1.55.0


================================================================================
6. Cost Sanity Check Before You Continue
================================================================================

The cluster you build in :ref:`set-up-gcp-cluster` has these
always-on baseline costs **before any GCHP job runs**:

.. list-table::
   :header-rows: 1
   :widths: 70 30

   * - Resource
     - Daily cost
   * - Filestore BASIC_HDD 1 TB
     - $6.67
   * - Controller VM (c2-standard-4)
     - $5.03
   * - Login VM (n2-standard-2)
     - $2.33
   * - Disks + IPs
     - ~$2.50
   * - **Idle baseline**
     - **~$18/day**

Each H4D node costs approximately **$10/hour** while running and
**$0/hour** when stopped (boot disks at ~$0.07/day remain). Plan to
stop the controller, login, and any compute nodes when you finish
work for the day. See the cost-control section of
:ref:`set-up-gcp-cluster` for the exact commands.


================================================================================
You are now ready
================================================================================

When all of the following are in place:

* Project linked to billing
* IAM roles granted
* APIs enabled
* Quotas approved
* ``gcloud``, ``terraform``, and ``gcluster`` installed locally

proceed to :ref:`set-up-gcp-cluster` to build the cluster.
