#!/bin/bash

if [ ! -f "docker-buildx" ]; then
    echo "Downloading buildx..."
    wget https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64
    mv buildx-v0.3.1.linux-amd64 docker-buildx
    chmod o+x docker-buildx
fi

if [ ! -f "qemu-aarch64-static" ]; then
    echo "Downloading qemu-aarch64-static..."
    wget https://github.com/multiarch/qemu-user-static/releases/download/v4.2.0-2/qemu-aarch64-static
fi
