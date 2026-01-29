# Docker

## GCP Backup

```bash
5 0 * * * /usr/bin/docker run --rm --network=host --env-file /home/$USER/self-hosted/docker/.env.backup.umami ghcr.io/kahnwong/docker-aws-backup:b46d44d
```

## Oracle Backup

```bash
1 0 * * * /usr/bin/docker run --rm --env-file /home/ubuntu/self-hosted/docker/.env.backup.memos -v /opt/memos:/opt/memos ghcr.io/kahnwong/docker-aws-backup:b46d44d
1 0 * * * /usr/bin/docker run --rm --env-file /home/ubuntu/self-hosted/docker/.env.backup.vaultwarden -v /opt/vaultwarden:/opt/vaultwarden ghcr.io/kahnwong/docker-aws-backup:b46d44d
```

## pmtiles

```bash
pmtiles extract https://build.protomaps.com/$(date -d "yesterday" +%Y%m%d).pmtiles bangkok.pmtiles --bbox=100.327912387,13.493389571,100.938516257,13.955198179
```

## DDNS

```bash
*/5 * * * * cd /home/ubuntu && /usr/bin/docker compose -f compose-bird-cron.yaml run --rm ddns
```

## Syncthing

Set global ignore patterns

```text
**/node_modules/**
**/dist/**
node_modules
dist
```
