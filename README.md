# self-hosted setup

- [self-hosted setup](#self-hosted-setup)
  - [Prelim config](#prelim-config)
    - [Enable SSH + WiFi (pi only)](#enable-ssh--wifi-pi-only)
  - [FFMPEG binary](#ffmpeg-binary)
  - [mount external storage](#mount-external-storage)
  - [crontab](#crontab)
  - [webserver](#webserver)
  - [wallabag](#wallabag)
    - [theme](#theme)
  - [Docker](#docker)
    - [db backup & restore](#db-backup--restore)
    - [grant $USER permission to run docker without sudo](#grant-user-permission-to-run-docker-without-sudo)

## Prelim config
1. Change password + timezone
2. set ssh_key
3. disable password prompt for sudo
```bash
sudo visudo
$USERNAME ALL=(ALL) NOPASSWD:ALL
```
4. set console charset
```bash
apt-get install locales
sudo localectl set-locale LANG=en_US.UTF-8
dpkg-reconfigure locales
```
5. Install packages
```bash
sudo apt install tmux certbot ntfs-3g ftp fail2ban -y
```

### Enable SSH + WiFi (pi only)
1. Put empty `ssh` file at `boot`
2. Add WiFi info to `wpa_supplicant.conf` at `boot`
  
```bash
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid=$SSID
    psk=$PASSWORD
}
```

## FFMPEG binary
https://www.johnvansickle.com/ffmpeg/


## mount external storage
Add the following (pi only):
```bash
# /boot/config.txt
max_usb_current=1
```

```bash
# sudo nano /etc/fstab
UUID=D424912B2491119A /mnt/media ntfs-3g uid=1000,gid=1000,nofail,umask=0 0 0

# for vfat w utf8 support
UUID=1B18-1165 /mnt/media vfat iocharset=utf8,uid=1000,gid=1000,nofail,umask=0 0 0
```


## crontab
```bash
FTP_HOST=
FTP_USER=
FTP_PASSWORD=

0 2 * * * /root/self-hosted/scripts/backup_dell.sh > /dev/null 2>&1
*/15 * * * * docker exec -t gcal-agenda python3 create_html.py
*/1 * * * * /root/duckdns/duck.sh >/dev/null 2>&1

0 4 * * * /root/self-hosted/scripts/daily_container_update.sh > /dev/null 2>&1
0 5 * * * /root/self-hosted/scripts/daily_cleanup.sh > /dev/null 2>&1

PATH=/usr/local/bin:$PATH
0 7 * * * cd /root/slack-notifications && pipenv run python3 main.py > /dev/null 2>&1

PATH=/usr/bin
*/1 * * * * cd /root/self-hosted && git pull
```

## webserver
```bash
$ systemctl reload caddy
$ caddy hash-password --algorithm bcrypt # create password hash
```

## wallabag
### theme
- https://github.com/STaRDoGG/Dark-Nord-Material-Theme-for-WallaBag

## Docker
`apt install docker docker-compose`

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

### grant $USER permission to run docker without sudo
`sudo usermod -aG docker $USER`