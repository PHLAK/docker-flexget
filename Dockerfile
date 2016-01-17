FROM alpine:3.3
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Define Flexget version
ENV FLEXGET_VERSION 1.2.428

# Create Flexget directories
RUN mkdir -pv /opt/flexget /etc/flexget

# Set flexget archive URL
ENV TARBAL_URL https://api.github.com/repos/flexget/flexget/tarball/${FLEXGET_VERSION}

# Install dependencies
RUN apk add --update ca-certificates python py-pip tar wget \
    && wget -qO- ${TARBAL_URL} | tar -xz --strip-components=1 -C /opt/flexget \
    && apk del tar wget && rm -rf /var/cache/apk/*

# Install requirements
RUN pip install --upgrade -r /opt/flexget/rtd-requirements.txt \
    && pip install --upgrade cssmin enum34 "guessit>=0.9.3,<0.10.4" flask-assets \
    flask-compress flask-login flask-restplus==0.7.2 pathlib pyparsing pyScss \
    && rm -r ~/.cache/pip/*

# Define volumes
VOLUME /etc/flexget

# Default command
CMD ["/opt/flexget/flexget_vanilla.py", "-c", "/etc/flexget/config.yml", "daemon", "start"]
