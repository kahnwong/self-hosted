# ###############
# # bitwarden
# ###############
# bitwarden_backup_filename="bitwarden-"$current_date".tar.gz"

# echo "bitwarden..."
# tar -czf $bitwarden_backup_filename /opt/bitwarden

# aws s3 cp --endpoint-url $r2_endpoint $bitwarden_backup_filename "$backup_path_prefix/$bitwarden_backup_filename"
# rm $HOME"/"$bitwarden_backup_filename

# ###############
# # kanboard
# ###############
# kanboard_sqldump_filename="kanboard-"$current_date".sql"

# echo "kanboard..."
# docker exec kanboard_db /usr/bin/mysqldump -u root --password=secret kanboard > $kanboard_sqldump_filename

# aws s3 cp --endpoint-url $r2_endpoint $kanboard_sqldump_filename "$backup_path_prefix/$kanboard_sqldump_filename"
# rm $HOME"/"$kanboard_sqldump_filename

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
# rm $HOME"/"$jellyfin_backup_filename

###############
# ttrss
###############
echo "ttrss..."
ttrss_backup_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.tar.gz | tail -1)
ttrss_sqldump_filename=$(ls -1 /var/lib/docker/volumes/ttrss-docker-compose_backups/_data/*.sql.gz | tail -1)

aws s3 cp --endpoint-url $r2_endpoint $ttrss_backup_filename "$backup_path_prefix/ttrss-config"$current_date".tar.gz"
aws s3 cp --endpoint-url $r2_endpoint $ttrss_sqldump_filename "$backup_path_prefix/ttrss-sqldump-"$current_date".tar.gz"
