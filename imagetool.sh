#!/bin/bash

function usage()
{
    echo "Example :"
    echo "    ./imagetool.sh build -t oci/local liihb/os:1.0"
    echo "    ./imagetool.sh push liihb/os:1.0"
    echo "    ./imagetool.sh pull liihb/os:1.0"
}

function env_check()
{
    if [ $(uname -m) != "x86_64" ]; then
        echo ERROR: This script is really used for building images on x86_64 machines.
        exit 1
    fi
    if [ ! $(type -P docker) ]; then
        echo ERROR: No docker installer. 1>&2
        echo ERROR: Please initialize with init_env.sh script.
        exit 1
    fi
    if [ ! -f "docker-buildx" ]; then
        echo ERROR: docker-buildx script should put in current dir.
        exit 1
    fi
    if [ ! -f "Dockerfile_app" ]; then
        echo ERROR: Dockerfile_app should put in current dir.
        exit 1
    else
        cp Dockerfile_app Dockerfile
        docker images | grep "qemu-user-static"
        if [ "$?" != 0 ]; then
            echo INFO: registed qemu-user-static
            docker run --rm --privileged multiarch/qemu-user-static:register
        fi
    fi
}

env_check
if [ ! -n "$1" ]; then
    usage
    exit 1
fi

CMD="$1"
if [ ${CMD} == "build" ]; then
    if [ ! -n "$2" ]; then
        usage
        exit 1
    fi
    if [ "$2" == "-t" ]; then
        if [ ! -n "$3" ]; then
            usage
            exit 1
        fi
        if [ ! -n "$4" ]; then
            usage
            exit 1
        fi
        if [ "$3" == "oci" ]; then
            ./docker-buildx build -t "$4" -o type=docker,dest=oci.tar .
            echo "oci image generated: oci.tar"
        elif [ "$3" == "local" ]; then
            docker build -t "$4" .
        else
            usage
            exit 1
        fi
    else
        usage
        exit 1
    fi
elif [ ${CMD} == "push" ]; then
    if [ ! -n "$2" ]; then
        usage
        exit 1
    fi
    docker push "$2"
elif [ ${CMD} == "pull" ]; then
    if [ ! -n "$2" ]; then
        usage
        exit 1
    fi
    docker pull "$2"
else
    usage
    exit 1
fi


