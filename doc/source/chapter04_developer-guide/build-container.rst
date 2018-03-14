Build your own containers
=========================

Docker is ubiquitous in the software world but Singularity feels much more intuitive for people from the scientific computing world. To engage scientists more easily, consider Singularity. Its `documentation <http://singularity.lbl.gov>`_ is pretty easy to follow. The recipe for the container used in the tutorial is `available for reference <https://github.com/JiaweiZhuang/Singularity_GC>`_.

Note that Singularity interoperates pretty well with Docker. Because Docker has a lot more base images, Singularity images are often started with Docker images (shown by ``BootStrap: docker`` on the top of the recipe).