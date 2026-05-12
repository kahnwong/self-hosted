#!/bin/bash

sops -d bird.header.sops.Caddyfile >bird.header.Caddyfile
sops -d bird.private.sops.Caddyfile >bird.private.Caddyfile
sops -d fd.header.sops.Caddyfile >fd.header.Caddyfile
sops -d fd.private.sops.Caddyfile >fd.private.Caddyfile
