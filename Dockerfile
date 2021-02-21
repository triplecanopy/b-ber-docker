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

# Download URL and source path for calibre
ENV CALIBRE_SOURCE_URL https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py
ENV PATH $PATH:/opt/calibre

# ebook-convert options for Qt to allow running as root
ENV QTWEBENGINE_CHROMIUM_FLAGS "--no-sandbox"

# Calibre requires this to be set with 7700 when building PDFs
ENV XDG_RUNTIME_DIR "/home/xdg-runtime"

RUN apt-get update && apt-get install -y \
  wget \
  python \
  xz-utils \
  xdg-utils \
  python-pip \
  zip \
  python-dev \
  default-jre \
  && wget -O- "${CALIBRE_SOURCE_URL}" | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True, version='4.23.0')" \
  && rm -rf /tmp/calibre-installer-cache \
  && python -m pip install -U pip awscli \
  && npm i -g node-sass --unsafe-perm \
  && mkdir "${XDG_RUNTIME_DIR}" \
  && chmod 7700 "${XDG_RUNTIME_DIR}"
