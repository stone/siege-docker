FROM --platform=$BUILDPLATFORM debian:bookworm-slim AS builder
ENV SIEGE_VERSION=4.1.7

# Install and build Siege from source
RUN set -ex && \
  mkdir -p /app && \
  cd /app && \
  apt-get update && \
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
  make install && \
  apt-get purge -y --auto-remove $buildDeps

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
