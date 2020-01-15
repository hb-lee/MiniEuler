#!/bin/bash

if [ $(uname -m) == "aarch64" ]; then    ## on Euler OS
    echo -e "Init ENV on arm64 Euler OS platform..."
    if [ ! $(type -P docker) ]; then
        echo -e "Installing docker..."
        yum install -y docker
    fi
    if [ ! -f "docker-buildx" ]; then
        echo -e "Downloading docker-buildx..."
        wget https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-arm64
        mv buildx-v0.3.1.linux-arm64 docker-buildx
        chmod o+x docker-buildx
    fi
elif [ $(uname -m) == "x86_64" ]; then
    cat /etc/issue | grep Ubuntu
    if [ "$?" == 0 ]; then    ## Ubuntu
        echo -e "Init ENV on x86 Ubuntu platform..."
        if [ ! $(type -P docker) ]; then
            echo -e "Installing docker..."
            apt-get install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add ¨C
            add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            apt-get update
            apt-get install docker-ce -y
            sudo service docker start
        fi
    else
        echo -e "Init ENV on x86 CentOS platform..."
        if [ ! $(type -P docker) ]; then
            echo -e "Installing docker..."
            yum install -y yum-utils device-mapper-persistent-data lvm2
            yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            yum install -y docker-ce docker-ce-cli containerd.io
            systemctl start docker
        fi
    fi
    if [ ! -f "docker-buildx" ]; then
        echo -e "Downloading docker-buildx..."
        wget https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64
        mv buildx-v0.3.1.linux-amd64 docker-buildx
        chmod o+x docker-buildx
    fi
    if [ ! -f "qemu-aarch64-static" ]; then
        echo -e "Downloading arm64 qemu..."
        wget https://github.com/multiarch/qemu-user-static/releases/download/v4.2.0-2/qemu-aarch64-static
        chmod o+x qemu-aarch64-static
    fi
fi

echo -e "ENV Initialize Finished!"
