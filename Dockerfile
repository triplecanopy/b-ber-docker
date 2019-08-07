FROM node:12.7-buster

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG IMAGE_VERSION

LABEL maintainer="maxwell.simmer@gmail.com"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="b-ber"
LABEL org.label-schema.description="A Docker image for creating b-ber projects"
LABEL org.label-schema.url="https://www.canopycanopycanopy.com/"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vcs-url=$VCS_URL
LABEL org.label-schema.license="MIT"
LABEL org.label-schema.vendor="Triple Canopy"
LABEL org.label-schema.version=$IMAGE_VERSION
LABEL org.label-schema.schema-version="1.0"

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
  --unsafe-perm
