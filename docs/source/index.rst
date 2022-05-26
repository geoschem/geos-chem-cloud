Running GEOS-Chem on AWS cloud -- it is easy!
=============================================

`GEOSChem-on-cloud <http://acmg.seas.harvard.edu/research.html#cloud>`_ project provides fast and easy access to the latest, standard `GEOS-Chem <http://acmg.seas.harvard.edu/geos/>`_ model and `all its input datasets <https://registry.opendata.aws/geoschem-input-data/>`_  on the `Amazon Web Services (AWS) cloud <https://aws.amazon.com>`_.

See :ref:`Quick start guide <quick-start-label>` to start your first GEOS-Chem simulation within 15 minutes (and within seconds for the next time). See :ref:`motivation-label` for the motivation of this project.

This project is supported by the `AWS Public Data Set Program <https://aws.amazon.com/opendata/public-datasets/>`_ and the `NASA Atmospheric Composition Modeling and Analysis Program (ACMAP) <https://science.nasa.gov/earth-science/focus-areas/atmospheric-composition>`_.

.. note::
  **How to request support**: For any questions, bug reports, or functionality requests, please post your issue on the `GitHub issue tracker <https://github.com/geoschem/geos-chem-cloud/issues>`_. All you need is `a free GitHub account <https://github.com/join>`_. Alternatively, you can contact Jiawei Zhuang (jiaweizhuang@g.harvard.edu) and Bob Yantosca (yantosca@seas.harvard.edu). Using the GitHub issue tracker is the preferred approach because all discussions are public and can be easily found by anyone with similar problems.

  **Help us improving the user experience**: You are invited to attend our `user survey <https://github.com/geoschem/geos-chem-cloud/issues/15>`_!

How to use this documentation
-----------------------------

**For GEOS-Chem users**, this website contains everything you need in order to use GEOS-Chem on the cloud. You will be able to finish a complete research workflow, from model simulations to output data analysis and management. **If it is your first time trying GEOS-Chem, this project is perhaps your best starting point**, because :ref:`you don't need to do any initial setup <motivation-label>` and the model is guaranteed to work correctly (see :ref:`quick start guide <quick-start-label>`). For more details about the GEOS-Chem model itself, please refer to our comprehensive `user guide <http://acmg.seas.harvard.edu/geos/doc/man/>`_ and `wiki <http://wiki.seas.harvard.edu/geos-chem/index.php/Main_Page>`_.

**For non-GEOS-Chem-users**, this documentation can be used as an introduction to AWS for scientific computing, especially for **Earth science model simulations**. Since all Earth science models are highly similar from a software perspective, it should be quite easy to adapt this guide for you specific use case. More than 90% of this website is about general AWS concepts and tutorials, which doesn't require GEOS-Chem-specific knowledge. Please get a feeling of cloud computing workflow by exploring :doc:`beginner tutorials <./chapter02_beginner-tutorial/index>` and then refer to the :doc:`developer guide <./chapter04_developer-guide/index>` to build your own model. Although cloud computing has a lot of potential in Earth science, it is still significantly under-utilized due to :doc:`the lack of accessible tutorials <./chapter01_overview/external-resources>` for Earth science researchers. This project tries to fill this gap.

For general reference, GEOS-Chem is a `Chemical Transport Model <https://en.wikipedia.org/wiki/Chemical_transport_model>`_ for simulating atmospheric chemical compositions. It has been developed over 20 years and is used by `more than 100 research groups worldwide <http://acmg.seas.harvard.edu/geos/geos_people.html>`_. The program is mainly written in Fortran 90. `All model source code <https://github.com/geoschem>`_ is `distributed freely under the MIT license <http://acmg.seas.harvard.edu/geos/geos_licensing.html>`_. Input and output data formats are mostly NetCDF, which can be analyzed easily by most languages such as Python, R and MATLAB. IDL (Interactive Data Language) has historically been the major data analysis tool but now we embrace open-source tools especially Python, `Jupyter <http://jupyter.org>`_ and `xarray <http://xarray.pydata.org>`_. The classic version of GEOS-Chem uses OpenMP parallelization (shared-memory, multi-threading). `The MPI version of GEOS-Chem <https://www.geosci-model-dev.net/11/2941/2018/gmd-11-2941-2018.html>`_ and we are now testing it in a thousand-core cloud-HPC environment.


Table of Contents
-----------------

.. toctree::
   :maxdepth: 2

   chapter01_overview/index
   chapter02_beginner-tutorial/index
   chapter03_advanced-tutorial/index
   chapter04_developer-guide/index
   chapter05_aws-in-detail/index
   chapter06_appendix/index
