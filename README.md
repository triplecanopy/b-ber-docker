# b-ber

[!["Version"](https://img.shields.io/docker/v/canopycanopycanopy/b-ber?sort=semver)](https://hub.docker.com/r/canopycanopycanopy/b-ber/tags)
[!["Image Size"](https://img.shields.io/docker/image-size/canopycanopycanopy/b-ber?sort=semver)](https://hub.docker.com/r/canopycanopycanopy/b-ber/tags)
[!["License"](https://img.shields.io/github/license/triplecanopy/b-ber-docker)](https://github.com/triplecanopy/b-ber-docker/blob/master/LICENSE)

A Dockerfile for creating b-ber projects

## Pull

```
docker pull canopycanopycanopy/b-ber:1.0.1
```

## Build

```
docker build . -t canopycanopycanopy/b-ber -f ./Dockerfile
```

## Run

```
docker run -dit canopycanopycanopy/b-ber
```

## Test

```
docker exec -it <name> /bin/bash
```

## Publish

```
./version.sh # <major|minor|patch>
./publish.sh
```

## Changelog

```
yarn changelog
```

