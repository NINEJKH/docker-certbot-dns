FROM python:3.7-alpine
MAINTAINER 9JKH Dev<dev@9jkh.co.za>

ENTRYPOINT [ "certbot" ]
VOLUME /etc/letsencrypt /var/lib/letsencrypt

ARG certbot_version=0.35.1

# see: https://store.docker.com/community/images/certbot/certbot/dockerfile
RUN apk add --quiet --no-cache --virtual .certbot-deps \
  libffi \
  libssl1.1 \
  openssl \
  ca-certificates \
  binutils

RUN apk add --quiet --no-cache --virtual .build-deps \
  gcc \
  linux-headers \
  openssl-dev \
  musl-dev \
  libffi-dev && \
  pip3 install -qqq --no-cache-dir \
    "certbot-dns-cloudflare==${certbot_version}" \
    "certbot-dns-cloudxns==${certbot_version}" \
    "certbot-dns-digitalocean==${certbot_version}" \
    "certbot-dns-dnsimple==${certbot_version}" \
    "certbot-dns-dnsmadeeasy==${certbot_version}" \
    "certbot-dns-google==${certbot_version}" \
    "certbot-dns-luadns==${certbot_version}" \
    "certbot-dns-nsone==${certbot_version}" \
    "certbot-dns-rfc2136==${certbot_version}" \
    "certbot-dns-route53==${certbot_version}" && \
  apk del --quiet .build-deps
