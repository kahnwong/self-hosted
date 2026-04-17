#!/bin/bash

sudo caddy fmt --overwrite /etc/caddy/Caddyfile
curl localhost:2019/load \
	-H "Content-Type: text/caddyfile" \
	--data-binary @/etc/caddy/Caddyfile
