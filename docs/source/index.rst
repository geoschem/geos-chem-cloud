######################################
GEOS-Chem on cloud computing platforms
######################################

The **GEOS-Chem on cloud computing platforms**  project provides fast
and easy access to the latest, standard `GEOS-Chem
<http://geoschem.github.io>`_ model and `all its input datasets
<https://registry.opendata.aws/geoschem-input-data/>`_ on Amazon
Web Services (and perhaps in future, Google) cloud computing plaforms.

GEOS-Chem is a `Chemical Transport Model
<https://en.wikipedia.org/wiki/Chemical_transport_model>`_ for
simulating atmospheric chemical compositions. It has been developed
over 30 years and is used by `more than 100 research groups worldwide
<https://geoschem.github.io/users.html>`_. The program is mainly
written in Fortran 90. `All model source code
<https://github.com/geoschem>`_ is distributed freely under the `MIT
license <https://geoschem.github.io/license.html>`_. GEOS-Chem reads and
writes data in the netCDF data format, which can be analyzed easily by
most languages such as Python, R and MATLAB.

We are pleased to announce that this project is part of the `AWS Open
Data Sponsorship Program
<https://aws.amazon.com/opendata/open-data-sponsorship-program/>`_. As
a result, **GEOS-Chem input data hosted on AWS is completely free to
use**.


.. toctree::
   :maxdepth: 2
   :caption: GC-Classic on AWS cloud

   gcclassic-on-aws/gcc-AWS

.. toctree::
   :maxdepth: 2
   :caption: GCHP on AWS cloud

   gchp-on-aws/prepare-AWS-environment
   gchp-on-aws/setup-AWS-parallelcluster
   gchp-on-aws/AWS_terminology

.. seealso::
   This site focuses on cloud infrastructure. For comprehensive instructions on model configuration, compiling, and science updates, please refer to the other GEOS-Chem user manuals:

   * `GCHP Documentation <https://gchp.readthedocs.io/en/latest/index.html>`_
   * `GEOS-Chem Classic Documentation <https://geos-chem.readthedocs.io/en/latest/index.html>`_

.. toctree::
   :maxdepth: 2
   :caption: Help and Reference

   reference/key-references
   reference/CONTRIBUTING.md
   reference/SUPPORT.md
   reference/related-docs
   reference/editing-these-docs
