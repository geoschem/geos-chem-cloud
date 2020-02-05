# All scripts used for building GEOS-Chem on AWS cloud

## Steps to create GEOS-Chem AMI
(Note for the GEOS-Chem Support Team for future maintenance.)

0. Read main documentation http://cloud.geos-chem.org including the [developer guide](https://cloud-gc.readthedocs.io/en/latest/chapter04_developer-guide/index.html) to learn the basics.

1. Log into AWS using official Harvard ACMG account (contact Judit Flo Gaya)

2. Launch a fresh EC2 instance
- Step 1 Choose AMI: Select Ubuntu Server 18.04 LTS (ami-0ac019f4fcb7cb7e6)
- Step 2 Choose an Instance Type: r5.large ~ r5.xlarge are good for build & testing. Running GCHP needs r5.2xlarge. This can be changed after launch.
- Step 3 Configure Instance Details: Turn on [IAM role to access S3](https://cloud-gc.readthedocs.io/en/latest/chapter03_advanced-tutorial/iam-role.html) to avoid using AWS credentials on EC2. **Do not leave AWS credentials on public AMI**
- Step 4 Add Storage: [Increase EBS volume size](https://cloud-gc.readthedocs.io/en/latest/chapter02_beginner-tutorial/use-ebs.html#) to 100 GB (for GC-classic) or 150 GB (for GCHP) to host sample input data.

Can automate this by [AWSCLI command](https://cloud-gc.readthedocs.io/en/latest/chapter03_advanced-tutorial/advanced-awscli.html). It needs account-specific information so I don't put the script here.

3. Build GEOS-Chem (see [./build_environment/GC-classic](./build_environment/GC-classic) and [./build_environment/GCHP](./build_environment/GCHP) for full scripts). Three major steps are:
- Install libraries.
- Add environment file (bashrc).
- Get source code, compile the model.

4. Pull minimum neccessary input data from S3. See [./download_data/from_S3](./download_data/from_S3)
- NOTE: This step is no longer needed for GEOS-Chem 12.7.0 and later.  The deploy_GC.sh script will automatically do a GEOS-Chem dry-run and pull the required data from AWS to the EBS instance.

5. Test a short model run to generate output data. Remember to remove cap_restart for a successfully GCHP run so it won't affect the next run.

6. Install Anaconda python environment. See [./build_environment/python](./build_environment/python)

7. Run [sample Python code](https://cloud-gc.readthedocs.io/en/latest/chapter06_appendix/) on output data.

8. **Clean-up history** (see [./minor_util/clean_history.sh](./minor_util/clean_history.sh)). Save AMI. Change AMI permission to public.

9. **Using another account to test the new AMI**.

10. Update the AMI id in documentation. Possible places are:
- [Quck start guide](https://cloud-gc.readthedocs.io/en/latest/chapter02_beginner-tutorial/quick-start.html)
- [GCHP guide](https://cloud-gc.readthedocs.io/en/latest/chapter03_advanced-tutorial/gchp.html)
- [Resources list](https://cloud-gc.readthedocs.io/en/latest/chapter06_appendix/aws-resources-for-gc.html)

11. Create a new GitHub release tag, so that readthedocs can keep multiple [versions](https://docs.readthedocs.io/en/stable/versions.html). This allows users to access previous versions of docs. 

Final remarks:
- This process is semi-automated. Each step is automated (just run a few scripts), but the entire process still needs some manual operations. It is possible to automate the entire process using AWSCLI but that can be hard to debug. This only needs to be done after every major version release (12.1.0, 12.2.0) so hopefully the maintenance burden is minimal.
