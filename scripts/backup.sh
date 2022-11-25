#!/bin/bash
# https://developers.cloudflare.com/r2/examples/aws-cli/


current_date=`date +%Y-%m-%d`
remove_backup_before_date=`date +%Y-%m-%d -d "3 day ago"`
bucket_name="backup"
backup_path_prefix="s3://$bucket_name/$current_date"
r2_endpoint="https://$cloudflare_account_id.r2.cloudflarestorage.com"

home_dir="/root"
cd $home_dir

# ###############
# # bitwarden
# ###############
# bitwarden_backup_filename="bitwarden-"$current_date".tar.gz"

# echo "bitwarden..."
# tar -czf $bitwarden_backup_filename /opt/bitwarden

# aws s3 cp --endpoint-url $r2_endpoint $bitwarden_backup_filename "$backup_path_prefix/$bitwarden_backup_filename"
# rm $home_dir"/"$bitwarden_backup_filename

# ###############
# # kanboard
# ###############
# kanboard_sqldump_filename="kanboard-"$current_date".sql"

# echo "kanboard..."
# docker exec kanboard_db /usr/bin/mysqldump -u root --password=secret kanboard > $kanboard_sqldump_filename

# aws s3 cp --endpoint-url $r2_endpoint $kanboard_sqldump_filename "$backup_path_prefix/$kanboard_sqldump_filename"
# rm $home_dir"/"$kanboard_sqldump_filename

###############
# komga
###############
komga_backup_filename="komga-"$current_date".tar.gz"

echo "komga..."
tar -czf $komga_backup_filename /opt/komga/config/database.sqlite

aws s3 cp --endpoint-url $r2_endpoint $komga_backup_filename "$backup_path_prefix/$komga_backup_filename"
rm $home_dir"/"$komga_backup_filename

###############
# navidrome
###############
navidrome_backup_filename="navidrome-"$current_date".tar.gz"

echo "navidrome..."
tar --exclude "/opt/navidrome/config/cache" -czf $navidrome_backup_filename /opt/navidrome/config

aws s3 cp --endpoint-url $r2_endpoint $navidrome_backup_filename "$backup_path_prefix/$navidrome_backup_filename"
rm $home_dir"/"$navidrome_backup_filename

###############
# linkding
###############
linkding_backup_filename="linkding-"$current_date".tar.gz"

echo "linkding..."
tar -czf $linkding_backup_filename /opt/linkding

aws s3 cp --endpoint-url $r2_endpoint $linkding_backup_filename "$backup_path_prefix/$linkding_backup_filename"
rm $home_dir"/"$linkding_backup_filename


###############
# transmission
###############
transmission_backup_filename="transmission-"$current_date".tar.gz"

echo "transmission..."
tar -czf $transmission_backup_filename /opt/transmission/config

aws s3 cp --endpoint-url $r2_endpoint $transmission_backup_filename "$backup_path_prefix/$transmission_backup_filename"
rm $home_dir"/"$transmission_backup_filename

###############
# ttrss
###############
echo "ttrss..."
ttrss_backup_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.tar.gz | tail -1)
ttrss_sqldump_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.sql.gz | tail -1)

aws s3 cp --endpoint-url $r2_endpoint $ttrss_backup_filename "$backup_path_prefix/ttrss-config"$current_date".tar.gz"
aws s3 cp --endpoint-url $r2_endpoint $ttrss_sqldump_filename "$backup_path_prefix/ttrss-sqldump-"$current_date".tar.gz"

###############
# miniflux
###############
miniflux_sqldump_filename="miniflux-sqldump-"$current_date".psql"

echo "miniflux..."
PGPASSWORD=secret
/usr/bin/docker-compose -f /root/self-hosted/docker/docker-compose-miniflux.yml exec -T miniflux_db pg_dump -Fc -c -U miniflux > $home_dir"/"$miniflux_sqldump_filename

aws s3 cp --endpoint-url $r2_endpoint $miniflux_sqldump_filename "$backup_path_prefix/$miniflux_sqldump_filename"
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

aws s3 cp --endpoint-url $r2_endpoint $wallabag_backup_filename "$backup_path_prefix/$wallabag_backup_filename"
rm $home_dir"/"$wallabag_backup_filename

aws s3 cp --endpoint-url $r2_endpoint $wallabag_sqldump_filename "$backup_path_prefix/$wallabag_sqldump_filename"
rm $home_dir"/"$wallabag_sqldump_filename


###############
# photoprism
###############
photoprism_sqldump_filename="photoprism-sqldump-"$current_date".sql"

echo "photoprism..."
/usr/bin/docker-compose -f /root/self-hosted/docker/docker-compose-photoprism.yml exec -T photoprism photoprism backup -i - > $home_dir"/"$photoprism_sqldump_filename

aws s3 cp --endpoint-url $r2_endpoint $photoprism_sqldump_filename "$backup_path_prefix/$photoprism_sqldump_filename"
rm $home_dir"/"$photoprism_sqldump_filename


# ###############
# # jellyfin
# ###############
# jellyfin_backup_filename="jellyfin-"$current_date".tar.gz"

# echo "jellyfin..."
# tar --exclude "/opt/jellyfin/config/data/metadata" \
#     --exclude "/opt/jellyfin/config/data/transcodes" \
#     --exclude "/opt/jellyfin/config/cache" \
#     -czf $jellyfin_backup_filename /opt/jellyfin/config

# aws s3 cp --endpoint-url $r2_endpoint $jellyfin_backup_filename "$backup_path_prefix/$jellyfin_backup_filename"
# rm $home_dir"/"$jellyfin_backup_filename

curl -d "Successfully backup DELL 🤩" ntfy.sh/kwdellbackup

########
# REMOVE OLD BACKUPS
########

aws s3api list-objects-v2 \
--endpoint-url $r2_endpoint \
--bucket $bucket_name  \
--output text \
--query "Contents[?LastModified<= '$remove_backup_before_date'].[Key]" | xargs printf -- "s3://$bucket_name/%s\n" | xargs -L 1 aws s3 rm --endpoint-url $r2_endpoint
