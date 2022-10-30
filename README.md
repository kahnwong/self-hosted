# self-hosted setup

Notes: do not use snap docker. It has mount permission issues.

## Instructions
1. Install packages
```bash
$ sudo apt install ntfs-3g fail2ban fish neovim iotop progress python3.8-venv pipx ffmpeg fd-find docker docker-compose ncdu -y
$ sh -c "$(curl -fsSL https://starship.rs/install.sh)"
$ pipx install yt-dlp pre-commit
$ pipx ensurepath

#+ install sops, caddy, dbxcli
```
2. Setup duckdns
3. Set age for sops encrypt/decrypt at `/root/.config/sops/age/keys.txt`
4. Set youtube-dlp config at ~/yt-dlp.conf
```
-o "%(title)s.%(ext)s" --ignore-errors
# -f bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm]
#-f (bestvideo[ext!=webm]/bestvideo[ext!=av01])+bestaudio[ext!=webm]/$
#-f "(mp4)[height=1080][ext!=webm]+bestaudio[ext=m4a]"
#-f "(mp4)[width=1920][ext!=webm]+bestaudio[ext=m4a]"
#-f "(mp4)([width=1920]|[width=720])[ext!=webm]+bestaudio[ext=m4a]"
#-f "bestvideo[width<=1920][ext=mp4]+bestaudio[ext=m4a]"-f "(mp4)[wid$
-f "bestvideo[width<=1920][ext=mp4]+bestaudio[ext=m4a]"
```
5. Change login shell: `chsh` and type `/usr/bin/fish`
6. Set wallabag's graby site config
7. Spin up docker-composes
8. `chmod -R 0755 /opt/`
9. Setup [tailscale](https://tailscale.com/)

## FFMPEG binary
https://www.johnvansickle.com/ffmpeg/


## Snippets
### Audo mount storage
```bash
# sudo nano /etc/fstab
UUID=D424912B2491119A /mnt/media ntfs-3g uid=1000,gid=1000,nofail,umask=0 0 0

# for vfat w utf8 support
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
*/1 * * * * /root/duckdns/duck.sh >/dev/null 2>&1

PATH=/usr/bin
*/1 * * * * cd /root/self-hosted && git pull

0 4 * * * bash /root/self-hosted/scripts/daily_container_update.sh > /dev/null 2>&1
0 5 * * * bash /root/self-hosted/scripts/daily_cleanup.sh > /dev/null 2>&1
0 2 * * * bash /root/self-hosted/scripts/backup_dell.sh  > /dev/null 2>&1
```

## wallabag
### theme
- https://github.com/STaRDoGG/Dark-Nord-Material-Theme-for-WallaBag
