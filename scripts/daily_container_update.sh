#!/bin/bash
cd /root/self-hosted/docker

# rss-bridge
docker-compose -f docker-compose-rss-bridge.yml pull
docker-compose -f docker-compose-rss-bridge.yml down
docker-compose -f docker-compose-rss-bridge.yml up -d

# komga
docker-compose -f docker-compose-komga.yml pull
docker-compose -f docker-compose-komga.yml down
docker-compose -f docker-compose-komga.yml up -d

# calibre-web
docker-compose -f docker-compose-calibre-web.yml pull
docker-compose -f docker-compose-calibre-web.yml down
docker-compose -f docker-compose-calibre-web.yml up -d

cd /root/self-hosted/docker/invidious
git pull
docker-compose down
docker-compose build
docker-compose up -d
