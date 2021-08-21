FROM debian:bullseye

RUN set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
        apt-get install -y --no-install-recommends \
          unbound \
          dns-root-data \
          ca-certificates \
          ldnsutils

COPY data/ /opt/unbound

RUN mkdir -p /opt/unbound/conf

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["/opt/unbound/unbound.sh"]
