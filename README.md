# Caddy with Cloudflare DNS

A minimal Caddy image containing the
[`dns.providers.cloudflare`](https://github.com/caddy-dns/cloudflare) module for
ACME DNS-01 challenges.

## Included versions

- Caddy `2.11.4`
- Cloudflare DNS module `v0.2.4`

Versions are pinned in the `Dockerfile`. Dependabot monitors the Caddy base
images and GitHub Actions; Cloudflare module updates are explicit pull requests.

## Image

Images are published to:

```text
ghcr.io/pleasestopasking/caddy
```

The workflow publishes these tags:

- `latest` from the default branch
- Git tags such as `v2.11.4-1`
- Commit tags such as `sha-0123456`

Published images support `linux/amd64` and `linux/arm64` and include build
provenance attestations.

## Cloudflare token

Create a Cloudflare API token restricted to the required zone with only:

- `Zone:Zone:Read`
- `Zone:DNS:Edit`

Pass the token at runtime. Do not store it in this repository or bake it into
the image.

## Caddyfile

```caddyfile
foo.example.com {
	tls {
		dns cloudflare {env.CF_API_TOKEN}
		resolvers 1.1.1.1
	}

	reverse_proxy foo:80
}
```

Use local DNS to resolve `foo.example.com` to the server's private IP.
The public Cloudflare zone only needs to exist so Caddy can create the temporary
`_acme-challenge` TXT record; the service does not need to be exposed publicly.