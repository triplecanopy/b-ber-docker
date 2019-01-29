# b-ber

[![](https://images.microbadger.com/badges/version/canopycanopycanopy/b-ber.svg)](https://microbadger.com/images/canopycanopycanopy/b-ber "Version")
[![](https://images.microbadger.com/badges/image/canopycanopycanopy/b-ber.svg)](https://microbadger.com/images/canopycanopycanopy/b-ber "Image Layers")
[![](https://images.microbadger.com/badges/commit/canopycanopycanopy/b-ber.svg)](https://microbadger.com/images/canopycanopycanopy/b-ber "Commit")
[![](https://images.microbadger.com/badges/license/canopycanopycanopy/b-ber.svg)](https://microbadger.com/images/canopycanopycanopy/b-ber "License")

A Dockerfile for creating b-ber projects

## Build

```
$ docker build . -t bber -f ./Dockerfile
```

## Run

```
$ docker run -dit bber
```

## Test

```
$ docker exec -it <name> /bin/bash
```

## Publish

```
$ ./version # <major|minor|patch>
$ ./publish
```
