FROM alpine:3.10
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

# Define Flexget version
ARG FLEXGET_VERSION=3.0.13

# Create Flexget directories
RUN mkdir -pv /opt/flexget /etc/flexget

# Copy entrypoint script into image
COPY files/entrypoint.sh /opt/flexget/entrypoint.sh

# Create non-root user
RUN adduser -DHs /sbin/nologin flexget

# Set Flexget archive URL
ARG TARBALL_URL=https://api.github.com/repos/flexget/flexget/tarball/v${FLEXGET_VERSION}

# Download and extract Flexget archive and chown files
RUN apk add --update ca-certificates tar tzdata wget \
    && wget -qO- ${TARBALL_URL} | tar -xz --strip-components=1 -C /opt/flexget \
    && apk del --purge tar wget && rm -rf /var/cache/apk/* \
    && chown -R flexget:flexget /etc/flexget /opt/flexget

# Install dependencies
RUN apk add --update python3-dev \
    && pip3 install --no-cache-dir paver transmissionrpc \
    && pip3 install --no-cache-dir -e /opt/flexget \
    && rm -rf /var/cache/apk/*

# Set running user
USER flexget

# Define volumes
VOLUME /etc/flexget

# Set working directory
WORKDIR /opt/flexget

# Default entrypoint
ENTRYPOINT ["/opt/flexget/entrypoint.sh"]

# Default command
CMD ["flexget", "-c", "/etc/flexget/config.yml", "--loglevel", "verbose", "daemon", "start"]
