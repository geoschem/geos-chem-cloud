# https://wiki.centos.org/AdditionalResources/Repositories/SCL
# https://www.softwarecollections.org/en/scls/rhscl/devtoolset-7/
# https://centos.pkgs.org/7/centos-sclo-rh/devtoolset-7-gcc-gfortran-7.1.1-2.1.el7.x86_64.rpm.html
# https://centos.pkgs.org/7/centos-sclo-rh/devtoolset-7-gcc-c++-7.2.1-1.el7.x86_64.rpm.html

sudo yum install -y centos-release-scl
sudo yum install -y devtoolset-7-gcc-gfortran devtoolset-7-gcc-c++
# Executable are in /opt/rh/devtoolset-7/root/usr/bin

echo 'export PATH=/opt/rh/devtoolset-7/root/usr/bin:$PATH' >> ~/.bashrc