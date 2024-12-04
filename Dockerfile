FROM --platform=$BUILDPLATFORM debian:bookworm-slim AS builder
ARG SIEGE_VERSION=4.1.7

# Install and build Siege from source
RUN set -ex && \
  mkdir -p /app && \
  cd /app && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  curl \
  ca-certificates \
  libssl3 && \
  curl -O -L http://download.joedog.org/siege/siege-${SIEGE_VERSION}.tar.gz && \
  tar -xvzf siege-${SIEGE_VERSION}.tar.gz && \
  cd siege-${SIEGE_VERSION} && \
  ./configure && \
  make && \
  make install

FROM debian:bookworm-slim

COPY --from=builder /app/siege-*/src/siege /usr/local/bin/siege
COPY --from=builder /app/siege-*/utils/siege.config /usr/local/bin/siege.config
COPY --from=builder /app/siege-*/utils/siege2csv.pl /usr/local/bin/siege2csv
COPY --from=builder /app/siege-*/utils/bombardment /usr/local/bin/bombardment
COPY --from=builder /app/siege-*/doc/siegerc /etc/siegerc
COPY --from=builder /app/siege-*/COPYING /SIEGE-COPYING
RUN apt-get update && \
  apt-get install -y --no-install-recommends libssl3 ca-certificates zlib1g && \
  chmod 0655 /usr/local/bin/siege && \
  chmod 0655 /usr/local/bin/siege.config && \
  chmod 0655 /usr/local/bin/siege2csv && \
  chmod 0655 /usr/local/bin/bombardment && \
  chmod 0644 /etc/siegerc

ENTRYPOINT [ "/usr/local/bin/siege" ]
CMD [ "--help" ]

LABEL org.opencontainers.image.vendor="stone" \
  org.opencontainers.image.url="https://github.com/JoeDog/siege" \
  org.opencontainers.image.source="https://github.com/stone/siege-docker" \
  org.opencontainers.image.title="Siege" \
  org.opencontainers.image.description="Siege is an open source regression test and benchmark utility" \
  org.opencontainers.image.documentation="https://github.com/stone/siege-docker/blob/main/README.md" \
  org.opencontainers.image.licenses="gpl-3.0"
