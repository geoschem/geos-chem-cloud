Notes on security groups (EC2 firewall)
=======================================

In the :ref:`quick start guide <quick-start-label>` I asked you to :ref:`skip EC2 configuration details <skip-ec2-config-label>`. If you didn't follow my word and messed up "Step 6: Configure Security Group", you might have trouble ``ssh`` to your EC2 instance. (Mis-configured security group should be the most common reason why you cannot ``ssh`` to your server. For other possible situations, see `troubleshooting EC2 connection <https://aws.amazon.com/premiumsupport/knowledge-center/ec2-linux-ssh-troubleshooting/>`_.)

In Step 6, a new "security group" will be created by default, with the name "launch-wizard-x":

.. figure:: img/choose_security_group.png

"Security group" controls what IPs are allowed to access your server. As you already see in the warning message above, the current setting is to allow any IP to connect (the IP number "0.0.0.0/0" stands for all IPs, equivalent to selecting "Anywhere" in the "Source" option above), but only for `SSH <https://en.wikipedia.org/wiki/Secure_Shell>`_ type of connection (recall that "22" is the `port number <https://en.wikipedia.org/wiki/Port_(computer_networking)#Common_port_numbers>`_ for SSH). This is generally fine, as you also need to have the :ref:`EC2 Key Pair <keypair-label>` in order to access that server. You can further set "Source" to "My IP", to add one more layer of security (which means your friend won't be able to access your server even if they have your EC2 key pair).

However, if you messed it up, say selected the "default" security group:

.. figure:: img/default_security_group.png

In this case, what's under the "Source" option is the ID of the default security group itself. This means NO external IPs are allowed to connect to that server, so you won't be able to ``ssh`` to it from your own computer.

If you've already messed it up and launched the EC2 instance, right-click on your EC2 instance in the console, choose "Networking" - "Change Security Groups" to assign a more permissive security group.

.. figure:: img/change_security_group.png
  :width: 400 px

You can view existing security groups in the "Security Groups" page in the EC2 console:

.. figure:: img/security_group_console.png

If you've launched multiple EC2 instances following the exact steps in the :ref:`quick start guide <quick-start-label>` and always skipped "Step 6: Configure Security Group", you would see multiple security groups named "launch-wizard-1", "launch-wizard-2"... They are created automatically each time you launch new EC2 instances, have exactly the same settings (allow SSH connection from all IPs) so you only need to keep one. And just choose that one in "Step 6: Configure Security Group" during EC2 instance launching. You can also modify an existing security group by right clicking on it and choose "Edit inbound rules".

That's all you need to know about security groups. Unlike local HPC clusters that can force strict security control, cloud platforms are exposed to the entire world and thus need complicated security settings to deal with different situations. Say, do you plan to access the server only from you own computer, or want to open the access to your group members, or even open to a broader public? This complexity can be a bit confusing for beginners.