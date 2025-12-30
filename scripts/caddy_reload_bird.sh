#!/bin/bash

cd caddy/config || exit 1

rm all.Caddyfile
{
	sops -d bird.header.sops.Caddyfile
	cat bird.Caddyfile
	echo -e "\n"
	sops -d bird.misc.sops.Caddyfile
} >all.Caddyfile
