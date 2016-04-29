FROM alpine:3.3
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Define Flexget version
ENV FLEXGET_VERSION 2.0.7

# Create Flexget directories
RUN mkdir -pv /opt/flexget /etc/flexget

# Set Flexget archive URL
ENV TARBALL_URL https://api.github.com/repos/flexget/flexget/tarball/${FLEXGET_VERSION}

# Download and extract Flexget archive
RUN apk add --update ca-certificates tar wget \
    && wget -qO- ${TARBALL_URL} | tar -xz --strip-components=1 -C /opt/flexget \
    && apk del --purge tar wget && rm -rf /var/cache/apk/*

# Install dependencies
RUN apk add --update python-dev py-pip \
    && pip install --no-cache-dir paver transmissionrpc \
    && pip install --no-cache-dir -e /opt/flexget \
    && rm -rf /var/cache/apk/*

# Define volumes
VOLUME /etc/flexget

# Set working directory
WORKDIR /etc/flexget

# Default command
CMD ["flexget", "-c", "/etc/flexget/config.yml", "--loglevel", "verbose", "daemon", "start"]
