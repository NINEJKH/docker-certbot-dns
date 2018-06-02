FROM python:2-alpine
MAINTAINER 9JKH Dev<dev@9jkh.co.za>

ENTRYPOINT [ "certbot" ]
VOLUME /etc/letsencrypt /var/lib/letsencrypt

# see: https://store.docker.com/community/images/certbot/certbot/dockerfile
RUN apk update --quiet && apk add --quiet --no-cache --virtual .certbot-deps \
  libffi \
  libssl1.0 \
  openssl \
  ca-certificates \
  binutils

RUN apk update --quiet && apk add --quiet --no-cache --virtual .build-deps \
  gcc \
  linux-headers \
  openssl-dev \
  musl-dev \
  libffi-dev && \
  pip install -qqq --no-cache-dir \
    certbot-dns-alwaysdata==0.24.0 \
    certbot-dns-cloudflare==0.24.0 \
    certbot-dns-cloudxns==0.24.0 \
    certbot-dns-digitalocean==0.24.0 \
    certbot-dns-dnsimple==0.24.0 \
    certbot-dns-dnsmadeeasy==0.24.0 \
    certbot-dns-google==0.24.0 \
    certbot-dns-luadns==0.24.0 \
    certbot-dns-nsone==0.24.0 \
    certbot-dns-rfc2136==0.24.0 \
    certbot-dns-route53==0.24.0 && \
  apk del --quiet .build-deps
