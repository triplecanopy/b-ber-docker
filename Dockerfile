FROM mhart/alpine-node:latest

LABEL maintainer="maxwell.simmer@gmail.com"

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
    && wget -O- ${CALIBRE_SOURCE_URL} | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" \
    && rm -rf /tmp/calibre-installer-cache \
    && pip install -U pip \
    && pip install awscli

RUN npm i -g \
    @canopycanopycanopy/b-ber-cli@canary \
    @canopycanopycanopy/b-ber-grammar@canary \
    @canopycanopycanopy/b-ber-lib@canary \
    @canopycanopycanopy/b-ber-logger@canary \
    @canopycanopycanopy/b-ber-reader@canary \
    @canopycanopycanopy/b-ber-resources@canary \
    @canopycanopycanopy/b-ber-shapes@canary \
    @canopycanopycanopy/b-ber-tasks@canary \
    @canopycanopycanopy/b-ber-templates@canary \
    @canopycanopycanopy/b-ber-themes@canary \
    --unsafe-perm
