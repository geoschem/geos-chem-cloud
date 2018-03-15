AWS services in detail
======================

AWS just has too many services, often with strange names (if you think "EC2" and "S3" are not strange enough, look through all services in the AWS main console). Even web developers need something called "`AWS in Plain English <https://www.expeditedssl.com/aws-in-plain-english>`_" to figure out what those services actually are. For domain scientists who know almost nothing about web development (which is what AWS is mainly designed for), getting a full understanding of AWS is even more challenging.

So let me try to give another version of "AWS in Plain English", in scientific computing context. You can still get most of research tasks done without understanding those AWS stuff, but knowing them will make the AWS console and documentation look much less daunting. More importantly, you will get a big picture and know how to find the correct services to fulfill your particular research needs.

The :ref:`Researcher’s Handbook <researcher-handbook-label>` also gives a fairly accessible overview of AWS service for scientists. However, a single manual cannot cover enough details for all scientific disciplines, since different disciplines have vastly different workflows. For example, the workflow of `genomics processing <https://aws.amazon.com/health/genomics/>`_ almost never applies to Earth science research. Here I pay more attention on Earth science, including both model simulations and data analysis.

.. toctree::
   :maxdepth: 2

   common-concepts
   monitor-cost
   specific-services