#/bin/bash
# See https://hpc.github.io/charliecloud/install.html#manual-build-and-install
# also https://www.nas.nasa.gov/hecc/support/kb/creating-a-charliecloud-container-image-on-your-workstation-using-docker_560.html

# Install Docker first, using one of install_docker_*.sh scripts!

# additional dependencies for CharlieCloud on Ubuntu
# sudo apt-get install -y gcc make python

# additional dependencies for CharlieCloud on Amazon Linux
sudo yum install -y gcc

git clone https://github.com/hpc/charliecloud
cd charliecloud
make
sudo make install PREFIX=/usr/local

cd ..
rm -rf charliecloud