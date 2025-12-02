# Docker

## GCP Backup

```bash
1 0 * * * /usr/bin/docker run --env-file /home/$USER/self-hosted/docker/.env.backup.vaultwarden -v /opt/vaultwarden:/opt/vaultwarden ghcr.io/kahnwong/docker-aws-backup:7a5b35c
5 0 * * * /usr/bin/docker run --network=host --env-file /home/$USER/self-hosted/docker/.env.backup.umami ghcr.io/kahnwong/docker-aws-backup:7a5b35c
```

## Oracle Backup

```bash
1 0 * * * /usr/bin/docker run --env-file /home/ubuntu/self-hosted/docker/.env.backup.memos -v /opt/memos:/opt/memos ghcr.io/kahnwong/docker-aws-backup:7a5b35c
```

## pmtiles

```bash
pmtiles extract https://build.protomaps.com/$(date -d "yesterday" +%Y%m%d).pmtiles bangkok.pmtiles --bbox=100.327912387,13.493389571,100.938516257,13.955198179
```

## DDNS

```bash
*/5 * * * * cd /home/ubuntu && /usr/bin/docker compose -f compose-ddns.yaml run ddns
```
