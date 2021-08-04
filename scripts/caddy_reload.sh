#!/bin/bash
cp /root/self-hosted/docker/caddy/config/Caddyfile /etc/caddy/Caddyfile
systemctl reload caddy