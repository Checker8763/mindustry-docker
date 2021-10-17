#!/bin/sh

LATEST_VERSION="126.2"
IMAGE="mindustry"
DOCKER_USERNAME="checker8763"
FULL_IMAGE_NAME="$DOCKER_USERNAME/$IMAGE:$LATEST_VERSION"
LATEST_IMAGE_NAME="$DOCKER_USERNAME/$IMAGE:latest"


# build
docker build -t $FULL_IMAGE_NAME .

# tag as latest and version number
docker tag $FULL_IMAGE_NAME $LATEST_IMAGE_NAME

# push
dokcer push -a FULL_IMAGE_NAME
