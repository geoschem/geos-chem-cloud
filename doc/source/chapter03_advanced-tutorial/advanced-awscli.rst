More advanced usages of AWSCLI
==============================

Besides accessing S3, AWSCLI can control any kinds of AWS resources you can imagine. Very useful ones are ``aws ec2 run-instances`` (`official doc <https://docs.aws.amazon.com/cli/latest/reference/ec2/run-instances.html>`_) and ``aws ec2 request-spot-instances`` (`doc <https://docs.aws.amazon.com/cli/latest/reference/ec2/request-spot-instances.html>`_) as they save a lot of time clicking throught the console.

While ``aws s3 xxx`` are often used on EC2 instances to interact with S3, ``aws ec2 xxx`` are mostly used on local computers to control remote servers.

Launch on-demand instances
--------------------------

Use this bash script to launch an on-demand instance::

  #!/bin/bash
  
  # == often change ==
  TYPE=r4.large   # EC2 instance type

  # ==  set it once and seldom change ==
  AMI=ami-xxxxxxx # AMI to launch from
  SG=sg-xxxxxxxx  # security group ID
  KEY=xxx-key     # EC2 key pair name
  COUNT=1         # how many instances to launch
  IAM=xxxxx       # EC2 IAM role name

  # == almost never change; just leave it as-is ==
  aws ec2 run-instances --image-id $AMI \
      --security-group-ids $SG --count $COUNT \
      --instance-type $TYPE --key-name $KEY \
      --iam-instance-profile Name=$IAM

- **TYPE**: `EC2 instance type <https://aws.amazon.com/ec2/instance-types/>`_.
- **AMI**: The AMI you want to launch from, such as :doc:`our tutorial AMI <../chapter06_appendix/aws-resources-for-gc>`.
- **SG**: The :doc:`security group <../chapter02_beginner-tutorial/security-group>` you want to assign to your EC2 instance.
- **KEY**: The EC2 Key Pair for ``ssh``. For example, in the quick start demo I used :ref:`my-aws-key <keypair-label>`.
- **COUNT**: You can launch multiple instances with exactly the same configurations
- **IAM**: The :doc:`IAM role <./iam-role>` for your EC2 instance. Primarily for granting S3 access.

Request spot instances
----------------------

For spot instances, use::

  #!/bin/bash

  # == often change ==
  TYPE=c5.4xlarge  # EC2 instance type
  MAXPRICE=0.68    # Price limit

  # ==  set it once and seldom change ==
  AMI=ami-xxxxxxx # AMI to launch from
  SG=sg-xxxxxxxx  # security group ID
  KEY=xxx-key     # EC2 key pair name
  COUNT=1         # how many instances to launch
  IAM=xxxxx       # EC2 IAM role name

  # == almost never change; just leave it as-is ==
  aws ec2 request-spot-instances --spot-price "$MAXPRICE" \
  --instance-count $COUNT --type "one-time" --launch-specification \
  '{
  "ImageId": "'"$AMI"'",
  "InstanceType": "'"$TYPE"'",
  "KeyName": "'"$KEY"'",
  "SecurityGroupIds": [ "'"$SG"'" ],
  "IamInstanceProfile": {"Name": "'"$IAM"'"}
  }'

- **MAXPRICE**: Usually use `on-demand pricing <https://aws.amazon.com/ec2/pricing/on-demand/>`_ as the limit. :ref:`Check out the actual spot pricing <spot-label>` to see the most cost-effective one.

Other options are exactly the same as the on-demand case.

Other use cases
---------------

You may also `describe EC2 instances <https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html>`_
or `stop EC2 instances <https://docs.aws.amazon.com/cli/latest/reference/ec2/stop-instances.html>`_ using AWSCLI. But it is very quick to do so from the console, too.
