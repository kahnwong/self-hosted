#!/bin/bash

git fetch
git reset origin/master --hard
cd /home/ubuntu/self-hosted/caddy/config || exit 1

{
	sops -d header.sops.Caddyfile
	cat Caddyfile
	cat misc.Caddyfile
	echo -e "\n"
	sops -d private.sops.Caddyfile
} >>all.Caddyfile

sudo cp /home/ubuntu/self-hosted/caddy/config/all.Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
