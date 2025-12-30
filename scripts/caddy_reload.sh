#!/bin/bash

git fetch
git reset origin/master --hard
cd /home/ubuntu/self-hosted/caddy/config || exit 1

{
	sops -d fd.header.sops.Caddyfile
	cat fd.Caddyfile
	cat fd.misc.Caddyfile
	echo -e "\n"
	sops -d fd.private.sops.Caddyfile
} >all.Caddyfile

sudo cp /home/ubuntu/self-hosted/caddy/config/all.Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
