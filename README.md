# self-hosted setup

Notes: do not use snap docker. It has mount permission issues.

## Instructions

1. Setup env via nix: <https://github.com/kahnwong/nix>
2. Setup Kubernetes: <https://github.com/kahnwong/k8s-playground>
3. Setup duckdns
4. Set wallabag's graby site config
5. Spin up docker-composes
6. `chmod -R 0755 /opt/`
7. `tailscale up`

## Snippets

### Use docker without sudo

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

### Auto mount storage

```bash
# sudo nano /etc/fstab
UUID=D424912B2491119A /mnt/media ntfs-3g uid=1000,gid=1000,nofail,umask=0 0 0

# for vfat with utf8 support
UUID=1B18-1165 /mnt/media vfat iocharset=utf8,uid=1000,gid=1000,nofail,umask=0 0 0
```

### Caddy

```bash
$ systemctl reload caddy
$ caddy hash-password --algorithm bcrypt # create password hash
```

### db backup & restore

```bash
# Backup !!!! add -T flag for docker exec if used in crontab !!!
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql
docker-compose -f /home/pi/self-hosted/docker/wallabag/docker-compose.yml exec db pg_dump -Fc -c -U wallabag > $home_dir"/"$wallabag_sqldump_filename

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE
gunzip < all_databases.gz | mysql -u USERNAME -p DATABASE

## pg
1. cp *.psql to container
1.5. drop database `DROP DATABASE database_to_drop WITH (FORCE)`
2. `pg_restore -d wallabag -U wallabag -C -c  wallabagdump.psql`
```

## crontab

```bash
PATH=/usr/bin

*/1 * * * * "$HOME"/duckdns/duckdns.sh >/dev/null 2>&1

# 0 4 * * * "$HOME"/self-hosted/scripts/daily_container_update.sh > /dev/null 2>&1


PATH=/usr/bin:/home/kahnwong/.nix-profile/bin

0 5 * * * "$HOME"/self-hosted/scripts/daily_cleanup.sh > /dev/null 2>&1

cloudflare_account_id=""
AWS_PROFILE="r2"
0 2 * * * "$HOME"/self-hosted/scripts/backup.sh > /dev/null 2>&1
```
