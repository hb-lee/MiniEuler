#!/bin/bash

# This shell run on Euler OS with arm64 platform
if [ ! $(type -P docker) ]; then
    echo "Installing docker..."
    yum -y install docker
fi

if [ ! -f "docker-buildx" ]; then
    echo "Please download docker-buildx"
    exit 1
fi

if [ ! -f "qemu-aarch64-static" ]; then
    echo "Downloading qemu-aarch64-static..."
    wget https://github.com/multiarch/qemu-user-static/releases/download/v4.2.0-2/qemu-aarch64-static
fi

echo "Building the image..."
./docker-buildx build -t app:1.0 -o type=docker,dest=app.tar -f Dockerfile_app
    
