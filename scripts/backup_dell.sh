#!/bin/bash
current_date=`date +%Y%m%d`

bitwarden_backup_filename="bitwarden-"$current_date".tar.gz"
booksonic_backup_filename="booksonic-"$current_date".tar.gz"
ghost_backup_filename="ghost-content-"$current_date".tar.gz"
ghost_sqldump_filename_gz="ghost-sqldump-"$current_date".sql.gz"
jellyfin_backup_filename="jellyfin-"$current_date".tar.gz"
kanboard_backup_filename="kanboard-"$current_date".tar.gz"
komga_backup_filename="komga-"$current_date".tar.gz"
linkding_backup_filename="linkding-"$current_date".tar.gz"
miniflux_sqldump_filename="miniflux-sqldump-"$current_date".psql"
navidrome_backup_filename="navidrome-"$current_date".tar.gz"
syncthing_backup_filename="syncthing-"$current_date".tar.gz"
transmission_backup_filename="jellyfin-"$current_date".tar.gz"
wallabag_backup_filename="wallabag-content-"$current_date".tar.gz"
wallabag_sqldump_filename="wallabag-sqldump-"$current_date".psql"
ttrss_backup_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.tar.gz | tail -1)
ttrss_sqldump_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.sql.gz | tail -1)
uptime_kuma_backup_filename="uptime-kuma-"$current_date".tar.gz"

home_dir="/root"
cd $home_dir

### tar-up data
echo "booksonic..."
tar --exclude "/opt/booksonic/config/*.gz" -czf $booksonic_backup_filename /opt/booksonic/config

echo "jellyfin..."
tar --exclude "/opt/jellyfin/config/data/transcodes" -czf $jellyfin_backup_filename /opt/jellyfin/config

echo "navidrome..."
tar --exclude "/opt/navidrome/config/cache" -czf $navidrome_backup_filename /opt/navidrome/config

echo "transmission..."
tar -czf $transmission_backup_filename /opt/transmission/config

echo "kanboard..."
tar -czf $kanboard_backup_filename /opt/kanboard

echo "komga..."
tar -czf $komga_backup_filename /opt/komga/config/database.sqlite

echo "miniflux..."
PGPASSWORD=secret
/usr/bin/docker-compose -f /root/self-hosted/docker/docker-compose-miniflux.yml exec -T miniflux_db pg_dump -Fc -c -U miniflux > $home_dir"/"$miniflux_sqldump_filename

echo "wallabag content..."
tar -czf $wallabag_backup_filename /opt/wallabag/images
echo "wallabag db..."
PGPASSWORD=wallapass
/usr/bin/docker-compose -f /root/self-hosted/docker/docker-compose-wallabag.yml exec -T wallabag_db pg_dump -Fc -c -U wallabag > $home_dir"/"$wallabag_sqldump_filename

echo "bitwarden..."
tar -czf $bitwarden_backup_filename /opt/bitwarden

echo "linkding..."
tar -czf $linkding_backup_filename /opt/linkding

echo "ghost..."
tar -czf $ghost_backup_filename /opt/ghost/content
/usr/bin/docker-compose -f /root/self-hosted/docker/docker-compose-ghost.yml exec -T ghost_db /usr/bin/mysqldump -u root --password=hellofriend ghost | gzip > $home_dir"/"$ghost_sqldump_filename_gz

echo "syncthing..."
tar -czf $syncthing_backup_filename /opt/syncthing/config

echo "uptime kuma..."
tar -czf $uptime_kuma_backup_filename /opt/uptime-kuma

### ftp transferr
ftp -n $FTP_HOST <<END_SCRIPT
quote USER $FTP_USER
quote PASS $FTP_PASSWORD
binary
cd Media/self-hosted-backup
put $bitwarden_backup_filename
put $booksonic_backup_filename
put $ghost_backup_filename
put $ghost_sqldump_filename_gz
put $jellyfin_backup_filename
put $kanboard_backup_filename
put $komga_backup_filename
put $linkding_backup_filename
put $miniflux_sqldump_filename
put $navidrome_backup_filename
put $syncthing_backup_filename
put $ttrss_backup_filename
put $ttrss_sqldump_filename
put $uptime_kuma_backup_filename
put $wallabag_backup_filename
put $wallabag_sqldump_filename
END_SCRIPT

### cleanup
rm $home_dir"/"$bitwarden_backup_filename
rm $home_dir"/"$booksonic_backup_filename
rm $home_dir"/"$ghost_backup_filename
rm $home_dir"/"$ghost_sqldump_filename_gz
rm $home_dir"/"$jellyfin_backup_filename
rm $home_dir"/"$kanboard_backup_filename
rm $home_dir"/"$komga_backup_filename
rm $home_dir"/"$linkding_backup_filename
rm $home_dir"/"$miniflux_sqldump_filename
rm $home_dir"/"$navidrome_backup_filename
rm $home_dir"/"$syncthing_backup_filename
rm $home_dir"/"$uptime_kuma_backup_filename
rm $home_dir"/"$wallabag_backup_filename
rm $home_dir"/"$wallabag_sqldump_filename
