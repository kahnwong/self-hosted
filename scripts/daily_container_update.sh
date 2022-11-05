#!/bin/bash
cd /root/self-hosted/docker

# komga
docker-compose -f docker-compose-komga.yml pull
docker-compose -f docker-compose-komga.yml down
docker-compose -f docker-compose-komga.yml up -d

# post-cleanup
docker system prune -f
