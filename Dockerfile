FROM node:9.11.1

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
ENV PATH $PATH:/opt/calibre

RUN apt-get update && apt-get install -y \
    wget \
    python \
    xz-utils \
    xdg-utils \
    python-pip \
    zip \
    python-dev \
    default-jre \
    && wget -O- ${CALIBRE_SOURCE_URL} | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" \
    && rm -rf /tmp/calibre-installer-cache \
    && pip install -U pip \
    && pip install awscli \
    && npm i -g \
    node-sass \
    phantomjs-prebuilt \
    --unsafe-perm
