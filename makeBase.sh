#!/bin/bash

if [ $(uname -m) != "aarch64" ]; then
    echo ERROR: This script should run on Euler OS arm64 platform.
    exit 1
fi

if [ ! $(type -P docker) ]; then
    echo "Installing docker..."
    yum -y install docker
fi

if [ ! -f "docker-buildx" ]; then
    echo "Downloading buildx..."
    wget https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-arm64
    mv buildx-v0.3.1.linux-arm64 docker-buildx
    chmod o+x docker-buildx
fi

echo "Building the image..."
tar xvf MiniEuler.tar.gz
cp Dockerfile_baseos MiniEuler/Dockerfile
cd MiniEuler
../docker-buildx build -t baseos:1.0 -o type=docker,dest=baseos.tar .
echo "build oci image: baseos.tar (baseos:1.0)"
cd ..
