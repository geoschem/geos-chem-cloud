#!/bin/bash
# https://www.sylabs.io/guides/3.0/user-guide/installation.html#installation

# Dependencies
sudo yum update -y && \
    sudo yum groupinstall -y 'Development Tools' && \
    sudo yum install -y \
    openssl-devel \
    libuuid-devel \
    libseccomp-devel \
    wget \
    squashfs-tools

export VERSION=1.11 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
    . ~/.bashrc


go get -u github.com/golang/dep/cmd/dep

# Install singularity from source
go get -d github.com/sylabs/singularity

 export VERSION=v3.0.1 # or another tag or branch if you like && \
    cd $GOPATH/src/github.com/sylabs/singularity && \
    git fetch && \
    git checkout $VERSION # omit this command to install the latest bleeding edge code from master

./mconfig && \
    make -C ./builddir && \
    sudo make -C ./builddir install

# echo '. /usr/local/etc/bash_completion.d/singularity' >> ~/.bashrc