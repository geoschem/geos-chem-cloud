Final word on research workflow on cloud
========================================

Congrats! You've finished all beginner tutorials. Now you've learned enough AWS stuff to perform most of simulation, data analysis, and data managment tasks. These tutorials could feel pretty intense if you are new to cloud computing (although I really tried to make them as user-friendly as possible). Don't worry, repeat these practices several times and you will get familiar with the research workflow on the cloud very quickly. There are also advanced tutorials, but they are just add-ons and are really not necessary for just getting science done.

The major difference (in terms of research workflow) between local HPC clusters and cloud platforms is **data management**, and that's what new users might feel uncomfortable with. To get used to the cloud, the key is to use and love S3! On traditional local disks, any files you create will stay there overever (so I often end up leaving tons of random legacy files in my home directory). On the other hand, the pricing model of cloud storage (charge you by the exact amount of data) will force you to really think about what files should kept by transferring to S3, and what should be simply discarded (e.g. TBs of legacy data that are not used anymore).

There are also ways to make cloud platforms :ref:`behave like traditional HPC clusters <hpc-overview-label>`, but they can often bring more restrictions than benefits. To fully ultilize the power and flexibility of cloud platforms, directly use native, basic services like EC2 and S3.

Here's my typical research workflow for reference:

1. Launch EC2 instances from pre-configured AMI. Consider spot instances for big computing. (:doc:`Use AWSCLI to launch them with one command <../chapter03_advanced-tutorial/advanced-awscli>`.)
2. Prepare input data by pulling them from S3 to EC2. Put commonly used ``aws s3 cp`` commands into bash scripts.
3. Tweak model configurations as needed.
4. Run simulations :ref:`with tmux <keep-running-label>`. Log out and go to sleep if the model runs for a long time.
5. Use Python/Jupyter to analyze output data.
6. After simulation and data analysis tasks are done, upload output data and customized model configuration (mostly run directories) to S3. Or download them to local machines if necessary (Recall that :ref:`egress charge <data-egress-label>` is $90/TB; for several GBs the cost is negligible).
7. Once important data safely live on S3 or on your local machine, shut down EC2 instances to stop paying for CPU charges.
8. Go to write papers, attend meetings, do anything other than computing. During this time, no machines are running on the cloud, and the only cost is data storage on S3 ($23/TB/month). Consider `S3 - Infrequent Access <https://aws.amazon.com/blogs/aws/aws-storage-update-new-lower-cost-s3-storage-option-glacier-price-reduction/>`_ which costs half if the data will not be used for several months.
9. Whenever need to continue computing, launch EC2 instances, pull stuff from S3, start coding again.

I often use big instances (e.g c5.8xlarge) with spot pricing for computationally-expensive model simulations. But I also keep a less-powerful, on-demand instance (e.g. c5.large) for frequent data analysis workloads. Whenever I need to make a quick plot of model output data, I just start this on-demand instance, write Python code in Jupyter, and stop this instance when I am done. Since this on-demand instance just switches between "running" and "stopped" states but never "terminates", all files are preserved on disk, so I don't have to backup temporary files to S3 all the time.

When I need large computing power to `process data in parallel <http://xarray.pydata.org/en/stable/dask.html>`_, this on-demand instance can be easily `resized to a bigger type <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-resize.html>`_ like c5.8xlarge. Since data analysis tasks typically just take 1~2 hours (unlike model simulations that often take days), it doesn't worth the effort to set up spot instances to save one dollar.

