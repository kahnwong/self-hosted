#!/bin/bash
cp /root/self-hosted/caddy/config/Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy
