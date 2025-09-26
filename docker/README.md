# Docker

## GCP Backup

```bash
1 0 * * * /usr/bin/docker run --env-file /home/$USER/self-hosted/docker/.env.backup.vaultwarden -v /opt/vaultwarden:/opt/vaultwarden ghcr.io/kahnwong/docker-aws-backup:7a5b35c
5 0 * * * /usr/bin/docker run --network=host --env-file /home/$USER/self-hosted/docker/.env.backup.umami ghcr.io/kahnwong/docker-aws-backup:7a5b35c
```
