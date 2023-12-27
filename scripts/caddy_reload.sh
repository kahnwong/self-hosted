#!/bin/bash

cd /home/kahnwong/self-hosted/caddy/config || exit 1

cat Caddyfile >all.Caddyfile

{
	echo -e "\n"
	cat nuc.Caddyfile

	echo -e "\n"
	sops -d nuc.private.Caddyfile

	echo -e "\n"
	cat snikt.Caddyfile

	echo -e "\n"
	sops -d snikt.private.Caddyfile

	echo -e "\n"
	sops -d private.Caddyfile
} >>all.Caddyfile

sudo cp /home/kahnwong/self-hosted/caddy/config/all.Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
