FROM mhart/alpine-node:latest

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG IMAGE_VERSION
LABEL maintainer="maxwell.simmer@gmail.com" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="b-ber" \
      org.label-schema.description="A Docker image for creating b-ber projects" \
      org.label-schema.url="https://www.canopycanopycanopy.com/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/triplecanopy/b-ber-docker" \
      org.label-schema.vendor="Triple Canopy" \
      org.label-schema.version=$IMAGE_VERSION \
      org.label-schema.schema-version="1.0"

ENV CALIBRE_SOURCE_URL https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py
ENV PATH $PATH:/opt/calibre/bin

RUN apk update && apk upgrade && apk add \
    openjdk8-jre \
    python-dev \
    py-pip \
    zip \
    bash \
    ca-certificates \
    gcc \
    mesa-gl \
    python \
    qt5-qtbase-x11 \
    wget \
    xdg-utils \
    xz \
    \
    && wget -O- ${CALIBRE_SOURCE_URL} | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" \
    && rm -rf /tmp/calibre-installer-cache \
    && pip install -U pip \
    && pip install awscli \
    \
    && yarn add global \
    node-sass \
    phantomjs-prebuilt \
    epub-zipper \
    --unsafe-perm
