Simplify SSH login with config file
===================================

In the :ref:`quick start guide <quick-start-label>` you used a lengthy command ``ssh -i "xx.pem" ubuntu@xxx.com`` to login. To copy files by ``scp``, the command would be even longer::
  
  scp -i "xx.pem" local_file ubuntu@xxx.com:~/ 
  
Fortunately, those commands can be simplified to ``ssh ec2`` and ``scp local_file ec2:~/``, skipping the Key Pair argument ``-i "xx.pem"`` and even the EC2 address.

Set up SSH config file
^^^^^^^^^^^^^^^^^^^^^^

For example, say the full ssh command is::

  ssh -i "~/.ssh/my-aws-key.pem" ubuntu@ec2-35-169-93-188.compute-1.amazonaws.com

Just open the file ``~/.ssh/config`` (create it if doesn't exist), and enter the following content. Then you will be able to use the shortcuts. ::

  Host ec2
    Hostname ec2-35-169-93-188.compute-1.amazonaws.com
    user ubuntu
    IdentityFile ~/.ssh/my-aws-key.pem
    Port 22

"Host" is the shortcut you want to use in ``ssh`` and ``scp`` commands. "user", "IdentityFile" (EC2 Key Pair), and "Port" (always 22 for ``ssh``) are almost never changed for different EC2 instances. So you only need to change "Hostname" everytime you have a new instance.

Enable port forwarding
^^^^^^^^^^^^^^^^^^^^^^

Port forwarding for Jupyter can be done as usual::
  
  ssh ec2 -L 8999:localhost:8999

Or can be also included in ``~/.ssh/config`` so you simply need ``ssh ec2``::
  
  Host ec2
    Hostname ec2-35-169-93-188.compute-1.amazonaws.com
    user ubuntu
    IdentityFile ~/.ssh/my-aws-key.pem
    Port 22
    LocalForward 8999 localhost:8999

For multiple servers
^^^^^^^^^^^^^^^^^^^^

You can add multiple entries for multiple EC2 instances. Say you've launched a bigger instance in addition to the existing one::

  Host ec2
    Hostname ec2-35-169-93-188.compute-1.amazonaws.com
    user ubuntu
    IdentityFile ~/.ssh/my-aws-key.pem
    Port 22
  Host ec2-big
    Hostname xxxxx.com
    user ubuntu
    IdentityFile ~/.ssh/my-aws-key.pem
    Port 22

Additional notes
^^^^^^^^^^^^^^^^

1. Note that if you stop and then re-start an EC2 instance, its address will change. The address can be fixed by `AWS Elastic IP <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html>`_, but I find that modifying "Hostname" in ``~/.ssh/config`` is generally quicker.

2. Our tutorial AMI is based on Ubuntu, thus the user name. Other operating systems would have `different user names <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html#TroubleshootingInstancesConnectingMindTerm>`_.

3. There are similar tutorials for SSH Config `online <http://fuzzyblog.io/blog/aws/2016/09/20/aws-tutorial-08-using-ssh-s-config-file-with-your-aws-boxes.html>`_.