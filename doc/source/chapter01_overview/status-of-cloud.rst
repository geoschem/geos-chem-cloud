Status of cloud for scientific computing
========================================

Cloud was originally invented for web applications, not for scientific computing. But the interest in using cloud platforms for science is growing rapidly, especially in the recent 2~3 years. Technical tests on whether cloud is suitable for science have been done over 10 years, tracing back to `Evangelinos and Hill (2008) <http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.296.3779>`_ who tested `MITgcm <http://mitgcm.org>`_ on AWS. Now we start to see mature applications for daily research work -- the democratization of cloud computing!

Atmospheric models
------------------

`The Modeling Research in the Cloud Workshop <https://www.unidata.ucar.edu/events/2017CloudModelingWorkshop/>`_ was hosted by NCAR in 2017. Most presentation slides are `available online <https://www.unidata.ucar.edu/events/2017CloudModelingWorkshop/#schedule>`_.

Relavant applications
---------------------

- `OpenFOAM on cloud <https://cfd.direct/cloud/>`_. OpenFOAM is a popular library for computational fluid dynamics (CFD). The team `started cloud migration in 2015 <https://cfd.direct/cloud/year-1-cloud/>`_ and the project is now very mature. CFD simulations are very similar to atmospheric simulations from a computational perspective -- they both solve variants of Navier–Stokes equations and use MPI-based domain decomposition. 

University Classes
------------------

Scientific computing classes start to teach and use cloud platforms,
mostly AWS:

- `Harvard CS205 <http://iacs-courses.seas.harvard.edu/courses/cs205/index.html>`_, 
  2018 Spring, Computing Foundations for Computational Science

- `MIT 18.337/6.338 <http://courses.csail.mit.edu/18.337/2017/index.html>`_, 
  2017 Fall, Modern Numerical Computing in Julia

- `Duke STA663 <http://people.duke.edu/~ccc14/sta-663-2017/>`_, 
  2017, Computational Statistics in Python
  
- Also see :ref:`deep-learning-label`

(If you know more about them please let me know!)