#!/bin/bash

cd /home/kahnwong/self-hosted/caddy/config || exit 1

cat Caddyfile >all.Caddyfile
echo -e "\n" >>all.Caddyfile
sops -d private.Caddyfile >>all.Caddyfile

sudo cp /home/kahnwong/self-hosted/caddy/config/all.Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
