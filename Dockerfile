FROM alpine:3.11.5
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

# Define Flexget version
ARG FLEXGET_VERSION=3.1.47

# Create Flexget directories
RUN mkdir -pv /opt/flexget /etc/flexget

# Copy entrypoint script into image
COPY files/entrypoint.sh /opt/flexget/entrypoint.sh

# Create non-root user
RUN adduser -DHs /sbin/nologin flexget

# Set Flexget archive URL
ARG TARBALL_URL=https://api.github.com/repos/flexget/flexget/tarball/v${FLEXGET_VERSION}

# Download and extract Flexget archive and chown files
RUN apk add --update ca-certificates python3-dev tzdata \
    && apk add --update --virtual extraction-deps tar wget \
    && wget -qO- ${TARBALL_URL} | tar -xz --strip-components=1 -C /opt/flexget \
    && apk del --purge extraction-deps && rm -rf /var/cache/apk/* \
    && chown -R flexget:flexget /etc/flexget /opt/flexget

# Install dependencies
RUN  apk add --update --virtual build-dependencies jpeg-dev gcc musl-dev zlib-dev \
    && pip3 install --no-cache-dir paver transmissionrpc deluge-client \
    && pip3 install --no-cache-dir -e /opt/flexget \
    && apk del --purge build-dependencies && rm -rf /var/cache/apk/*

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
