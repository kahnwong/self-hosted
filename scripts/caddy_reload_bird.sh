#!/bin/bash

git fetch
git reset origin/master --hard
cd /home/ubuntu/self-hosted/caddy/config || exit 1

{
	cat Caddyfile.bird
} >all.Caddyfile

sudo cp /home/ubuntu/self-hosted/caddy/config/all.Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
