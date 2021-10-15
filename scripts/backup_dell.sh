#!/bin/bash
current_date=`date +%Y%m%d`
backup_path_prefix="/Apps/kw-dell-backup/$current_date"

home_dir="/root"
cd $home_dir

# ###############
# # bitwarden
# ###############
# bitwarden_backup_filename="bitwarden-"$current_date".tar.gz"

# echo "bitwarden..."
# tar -czf $bitwarden_backup_filename /opt/bitwarden

# dbxcli put $bitwarden_backup_filename "$backup_path_prefix/$bitwarden_backup_filename"
# rm $home_dir"/"$bitwarden_backup_filename

###############
# booksonic
###############
booksonic_backup_filename="booksonic-"$current_date".tar.gz"

echo "booksonic..."
tar --exclude "/opt/booksonic/config/*.gz" -czf $booksonic_backup_filename /opt/booksonic/config

dbxcli put $booksonic_backup_filename "$backup_path_prefix/$booksonic_backup_filename"
rm $home_dir"/"$booksonic_backup_filename

###############
# kanboard
###############
kanboard_backup_filename="kanboard-"$current_date".tar.gz"

echo "kanboard..."
tar -czf $kanboard_backup_filename /opt/kanboard

dbxcli put $kanboard_backup_filename "$backup_path_prefix/$kanboard_backup_filename"
rm $home_dir"/"$kanboard_backup_filename

###############
# komga
###############
komga_backup_filename="komga-"$current_date".tar.gz"

echo "komga..."
tar -czf $komga_backup_filename /opt/komga/config/database.sqlite

dbxcli put $komga_backup_filename "$backup_path_prefix/$komga_backup_filename"
rm $home_dir"/"$komga_backup_filename

###############
# navidrome
###############
navidrome_backup_filename="navidrome-"$current_date".tar.gz"

echo "navidrome..."
tar --exclude "/opt/navidrome/config/cache" -czf $navidrome_backup_filename /opt/navidrome/config

dbxcli put $navidrome_backup_filename "$backup_path_prefix/$navidrome_backup_filename"
rm $home_dir"/"$navidrome_backup_filename

###############
# linkding
###############
linkding_backup_filename="linkding-"$current_date".tar.gz"

echo "linkding..."
tar -czf $linkding_backup_filename /opt/linkding

dbxcli put $linkding_backup_filename "$backup_path_prefix/$linkding_backup_filename"
rm $home_dir"/"$linkding_backup_filename

###############
# syncthing
###############
syncthing_backup_filename="syncthing-"$current_date".tar.gz"

echo "syncthing..."
tar -czf $syncthing_backup_filename /opt/syncthing/config

dbxcli put $syncthing_backup_filename "$backup_path_prefix/$syncthing_backup_filename"
rm $home_dir"/"$syncthing_backup_filename

###############
# transmission
###############
transmission_backup_filename="transmission-"$current_date".tar.gz"

echo "transmission..."
tar -czf $transmission_backup_filename /opt/transmission/config

dbxcli put $transmission_backup_filename "$backup_path_prefix/$transmission_backup_filename"
rm $home_dir"/"$transmission_backup_filename

###############
# ttrss
###############
echo "ttrss..."
ttrss_backup_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.tar.gz | tail -1)
ttrss_sqldump_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.sql.gz | tail -1)

dbxcli put $ttrss_backup_filename "$backup_path_prefix/ttrss-config"$current_date".tar.gz"
dbxcli put $ttrss_sqldump_filename "$backup_path_prefix/ttrss-sqldump-"$current_date".tar.gz"

###############
# miniflux
###############
miniflux_sqldump_filename="miniflux-sqldump-"$current_date".psql"

echo "miniflux..."
PGPASSWORD=secret
/usr/bin/docker-compose -f /root/self-hosted/docker/docker-compose-miniflux.yml exec -T miniflux_db pg_dump -Fc -c -U miniflux > $home_dir"/"$miniflux_sqldump_filename

dbxcli put $miniflux_sqldump_filename "$backup_path_prefix/$miniflux_sqldump_filename"
rm $home_dir"/"$miniflux_sqldump_filename

###############
# wallabag
###############
wallabag_backup_filename="wallabag-content-"$current_date".tar.gz"
wallabag_sqldump_filename="wallabag-sqldump-"$current_date".psql"

echo "wallabag content..."
tar -czf $wallabag_backup_filename /opt/wallabag/images
echo "wallabag db..."
PGPASSWORD=wallapass
/usr/bin/docker-compose -f /root/self-hosted/docker/docker-compose-wallabag.yml exec -T wallabag_db pg_dump -Fc -c -U wallabag > $home_dir"/"$wallabag_sqldump_filename

dbxcli put $wallabag_backup_filename "$backup_path_prefix/$wallabag_backup_filename"
rm $home_dir"/"$wallabag_backup_filename

dbxcli put $wallabag_sqldump_filename "$backup_path_prefix/$wallabag_sqldump_filename"
rm $home_dir"/"$wallabag_sqldump_filename

###############
# jellyfin
###############
jellyfin_backup_filename="jellyfin-"$current_date".tar.gz"

echo "jellyfin..."
tar --exclude "/opt/jellyfin/config/data/metadata" --exclude "/opt/jellyfin/config/data/transcodes" -czf $jellyfin_backup_filename /opt/jellyfin/config

dbxcli put $jellyfin_backup_filename "$backup_path_prefix/$jellyfin_backup_filename"
rm $home_dir"/"$jellyfin_backup_filename
