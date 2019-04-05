#!/usr/bin/env bash

IMAGE_NAME="canopycanopycanopy/b-ber"
read -ra IMAGE_VERSION <<< "$(git describe --abbrev=0 --tags)"
read -ra IMAGE_ID <<< "$(docker images --filter reference=$IMAGE_NAME -q)"
read -ra VCS_REF <<< "$(git rev-parse --short HEAD)"
read -ra VCS_URL <<< "$(git config --get remote.origin.url)"
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo
echo "  Building:"
echo
echo "  Image Name: $IMAGE_NAME"
echo "  Image Version: $IMAGE_VERSION"
echo "  Image ID: $IMAGE_ID"
echo "  VCS Ref: $VCS_REF"
echo "  VCS URL: $VCS_URL"
echo "  Build Date: $BUILD_DATE"
echo

function deploy {
    docker build --build-arg VCS_REF="$VCS_REF" \
                 --build-arg VCS_REF="$VCS_URL" \
                 --build-arg BUILD_DATE="$BUILD_DATE" \
                 --build-arg IMAGE_VERSION="$IMAGE_VERSION" \
                 --build-arg LICENSE="MIT" \
                 -t "$IMAGE_NAME":"$IMAGE_VERSION" .
    docker tag "$IMAGE_ID" "$IMAGE_NAME":"$IMAGE_VERSION"
    docker push "$IMAGE_NAME":"$IMAGE_VERSION"
}

while true; do
    read -p "Does this look OK? [yN] " yn
    case $yn in
        [Yy]* ) deploy; break;;
        * ) exit;;
    esac
done
