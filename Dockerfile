ARG CADDY_VERSION=2.11.4
ARG CLOUDFLARE_MODULE_VERSION=v0.2.4

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

ARG CADDY_VERSION
ARG CLOUDFLARE_MODULE_VERSION

RUN xcaddy build "v${CADDY_VERSION}" \
  --with "github.com/caddy-dns/cloudflare@${CLOUDFLARE_MODULE_VERSION}"

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy