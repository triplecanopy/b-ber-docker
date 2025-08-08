#!/usr/bin/env bash

IMAGE_NAME="canopycanopycanopy/b-ber"

# Check that Docker is running
check_docker_status=$(docker info > /dev/null 2>&1)
if [[ $? -ne 0 ]]; then
    echo "Ensure the docker daemon is running before publishing"
    exit
fi

if [[ -n $(docker images --filter reference=$IMAGE_NAME -q) ]]; then
    echo "Remove existing image before proceeding by running \`docker rmi $IMAGE_NAME\`"
    exit
fi

# Verify credentials so that docker push doesn't bail
docker login

read -ra IMAGE_VERSION <<< "$(git describe --abbrev=0 --tags)"
read -ra VCS_REF <<< "$(git rev-parse --short HEAD)"
read -ra VCS_URL <<< "$(git config --get remote.origin.url)"
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo
echo "Building..."
echo
echo "  Image Name: $IMAGE_NAME"
echo "  Image Version: $IMAGE_VERSION"
echo "  VCS Ref: $VCS_REF"
echo "  VCS URL: $VCS_URL"
echo "  Build Date: $BUILD_DATE"
echo

function deploy {
    docker build --build-arg VCS_REF="$VCS_REF" \
                 --build-arg VCS_URL="$VCS_URL" \
                 --build-arg BUILD_DATE="$BUILD_DATE" \
                 --build-arg IMAGE_VERSION="$IMAGE_VERSION" \
                 -t "$IMAGE_NAME":"$IMAGE_VERSION" . --platform=linux/amd64

    read -ra IMAGE_ID <<< "$(docker images --filter reference=$IMAGE_NAME -q)"

    docker tag "$IMAGE_ID" "$IMAGE_NAME":"$IMAGE_VERSION"
    docker push "$IMAGE_NAME":"$IMAGE_VERSION"
}

# Confirm deploy
while true; do
    read -p "  Does this look OK? [yN] " yn
    case $yn in
        [Yy]* ) deploy; break;;
        * ) exit;;
    esac
done
