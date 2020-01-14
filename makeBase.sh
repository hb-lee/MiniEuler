#/bin/bash

# This shell run on Euler OS with arm64 platform
if [ ! $(type -P docker) ]; then
    echo "Installing docker..."
    yum -y install docker
fi

echo "Downloading buildx..."
wget https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64
mv buildx-v0.3.1.linux-amd64 docker-buildx
chmod o+x docker-buildx

echo "Building the image..."
tar xvf MiniEuler.tar.gz
cp Dockerfile MiniEuler
cd MiniEuler
../docker-buildx build -t baseos:1.0 -o type=docker,dest=baseos.tar .
