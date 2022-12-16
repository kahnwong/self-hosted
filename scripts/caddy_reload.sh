#!/bin/bash
cp "$HOME"/self-hosted/caddy/config/Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
