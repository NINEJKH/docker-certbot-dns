FROM python:3.12-alpine

ENTRYPOINT [ "certbot" ]
VOLUME /etc/letsencrypt /var/lib/letsencrypt

ARG certbot_version=3.0.0

# see: https://store.docker.com/community/images/certbot/certbot/dockerfile
RUN set -exo pipefail && \
    apk add --quiet --no-cache --virtual .certbot-deps \
        libffi \
        libssl3 \
        openssl \
        ca-certificates \
        binutils

RUN set -exo pipefail && \
    apk add --quiet --no-cache --virtual .build-deps \
        cargo \
        gcc \
        libffi-dev \
        linux-headers \
        musl-dev \
        openssl-dev \
        rust && \
    pip3 install -qqq --no-cache-dir \
        "certbot==${certbot_version}" \
        "certbot-dns-cloudflare==${certbot_version}" \
        "certbot-dns-digitalocean==${certbot_version}" \
        "certbot-dns-dnsimple==${certbot_version}" \
        "certbot-dns-dnsmadeeasy==${certbot_version}" \
        "certbot-dns-gehirn==${certbot_version}" \
        "certbot-dns-google==${certbot_version}" \
        "certbot-dns-linode==${certbot_version}" \
        "certbot-dns-luadns==${certbot_version}" \
        "certbot-dns-nsone==${certbot_version}" \
        "certbot-dns-ovh==${certbot_version}" \
        "certbot-dns-rfc2136==${certbot_version}" \
        "certbot-dns-route53==${certbot_version}" \
        "certbot-dns-sakuracloud==${certbot_version}" \
        "certbot-dns-bunny==${certbot_version}" \
        "certbot-dns-godaddy==2.8.0" \
        "certbot-dns-cloudxns==1.32.0" \
        "certbot-dns-gcore==0.1.8" && \
    apk del --quiet .build-deps
