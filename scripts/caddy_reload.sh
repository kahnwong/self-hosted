#!/bin/bash

sudo cp /home/kahnwong/self-hosted/caddy/config/Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
