# docker-certbot-dns

[![Build Status](https://travis-ci.com/NINEJKH/docker-certbot-dns.svg?branch=master)](https://travis-ci.com/NINEJKH/docker-certbot-dns)
[![Docker Pulls](https://img.shields.io/docker/pulls/9jkh/certbot-dns.svg)](https://hub.docker.com/r/9jkh/certbot-dns/)

A docker image providing certbot (0.24) + all official DNS plugins. This is
ideal if you want to create letsencrypt wildcard certificates.

## Pull

```bash
$ docker pull 9jkh/certbot-dns
```

## Example usage

1. Create IAM user with the following policy: [sample-aws-policy.json](https://github.com/certbot/certbot/blob/master/certbot-dns-route53/examples/sample-aws-policy.json)
2. See possible [boto3 environment variables](http://boto3.readthedocs.io/en/latest/guide/configuration.html#environment-variable-configuration)
3. See possible [dns plugins](https://certbot.eff.org/docs/using.html#dns-plugins)

### Prepare

```bash
$ mkdir -p "$(pwd)/letsencrypt"
$ docker pull 9jkh/certbot-dns
```

### Generate wildcard certificate over Route53

* staging acme v2 url: https://acme-staging-v02.api.letsencrypt.org/directory
* prod acme v2 url: https://acme-v02.api.letsencrypt.org/directory

```bash
$ docker run \
  -e "AWS_ACCESS_KEY_ID=abc123" \
  -e "AWS_SECRET_ACCESS_KEY=123abc" \
  --name "certbot-dns" \
  --volume "$(pwd)/letsencrypt:/etc/letsencrypt" \
  9jkh/certbot-dns \
  certonly \
  --server "https://acme-staging-v02.api.letsencrypt.org/directory" \
  --dns-route53 \
  --agree-tos \
  -m "dnsadmin@yourdomain.com" \
  --non-interactive \
  -d "*.yourdomain.com"
```

### Distribute (optional)

Optionally you could programmatically store the cert on S3 for other apps to
easiliy retrieve:

```bash
$ (cd "$(pwd)/letsencrypt/live/yourdomain.com" && zip -q -r - .) > yourdomain.com.zip
$ aws s3 cp yourdomain.com.zip s3://certs/yourdomain.zip
```
