#!/bin/bash

sops -e bird.header.Caddyfile >bird.header.sops.Caddyfile
sops -e bird.private.Caddyfile >bird.private.sops.Caddyfile
sops -e fd.header.Caddyfile >fd.header.sops.Caddyfile
sops -e fd.private.Caddyfile >fd.private.sops.Caddyfile
