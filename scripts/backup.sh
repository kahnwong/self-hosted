#!/bin/bash
# https://developers.cloudflare.com/r2/examples/aws-cli/

current_date=$(date +%Y-%m-%d)
remove_backup_before_date=$(date +%Y-%m-%d -d "3 day ago")
bucket_name="backup"
backup_path_prefix="s3://$bucket_name/$current_date"

# shellcheck disable=SC2154
r2_endpoint="https://$cloudflare_account_id.r2.cloudflarestorage.com"

cd "$HOME" || exit

###############
# navidrome
###############
navidrome_backup_filename="navidrome-$current_date.tar.gz"

echo "navidrome..."
tar --exclude "/opt/navidrome/config/cache" -czf "$navidrome_backup_filename" /opt/navidrome/config

aws s3 cp --endpoint-url "$r2_endpoint" "$navidrome_backup_filename" "$backup_path_prefix/$navidrome_backup_filename"
rm "$HOME/$navidrome_backup_filename"

###############
# ntfy
###############
ntfy_backup_filename="ntfy-$current_date.tar.gz"

echo "ntfy..."
tar -czf "$ntfy_backup_filename" /opt/ntfy

aws s3 cp --endpoint-url "$r2_endpoint" "$ntfy_backup_filename" "$backup_path_prefix/$ntfy_backup_filename"
rm "$HOME/$ntfy_backup_filename"

###############
# heimdall
###############
heimdall_backup_filename="heimdall-$current_date.tar.gz"

echo "heimdall..."
tar -czf "$heimdall_backup_filename" /opt/heimdall

aws s3 cp --endpoint-url "$r2_endpoint" "$heimdall_backup_filename" "$backup_path_prefix/$heimdall_backup_filename"
rm "$HOME/$heimdall_backup_filename"

###############
# linkding
###############
linkding_backup_filename="linkding-$current_date.tar.gz"

echo "linkding..."
tar -czf "$linkding_backup_filename" /opt/linkding

aws s3 cp --endpoint-url "$r2_endpoint" "$linkding_backup_filename" "$backup_path_prefix/$linkding_backup_filename"
rm "$HOME/$linkding_backup_filename"

###############
# transmission
###############
transmission_backup_filename="transmission-$current_date.tar.gz"

echo "transmission..."
tar -czf "$transmission_backup_filename" /opt/transmission/config

aws s3 cp --endpoint-url "$r2_endpoint" "$transmission_backup_filename" "$backup_path_prefix/$transmission_backup_filename"
rm "$HOME/$transmission_backup_filename"

###############
# miniflux
###############
miniflux_sqldump_filename="miniflux-sqldump-$current_date.psql"

echo "miniflux..."
MINIFLUX_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=miniflux-statefulset | tail -1 | awk '{print $1}')"
echo "$MINIFLUX_POD_NAME"

PGPASSWORD=secret
kubectl exec "$MINIFLUX_POD_NAME" -c postgres -- pg_dump -Fc -c -U miniflux >"$HOME/$miniflux_sqldump_filename"

aws s3 cp --endpoint-url "$r2_endpoint" "$miniflux_sqldump_filename" "$backup_path_prefix/$miniflux_sqldump_filename"
rm "$HOME/$miniflux_sqldump_filename"

###############
# wallabag
###############
### content
wallabag_backup_filename="wallabag-content-$current_date.tar.gz"

echo "wallabag content..."
tar -czf "$wallabag_backup_filename" /opt/wallabag/images

aws s3 cp --endpoint-url "$r2_endpoint" "$wallabag_backup_filename" "$backup_path_prefix/$wallabag_backup_filename"
rm "$HOME/$wallabag_backup_filename"

### db
wallabag_sqldump_filename="wallabag-sqldump-$current_date.psql"

echo "wallabag db..."
WALLABAG_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=wallabag-statefulset | tail -1 | awk '{print $1}')"
echo "$WALLABAG_POD_NAME"

# shellcheck disable=SC2034
PGPASSWORD=wallapass
kubectl exec "$WALLABAG_POD_NAME" -c postgres -- pg_dump -Fc -c -U wallabag >"$HOME/$wallabag_sqldump_filename"

aws s3 cp --endpoint-url "$r2_endpoint" "$wallabag_sqldump_filename" "$backup_path_prefix/$wallabag_sqldump_filename"
rm "$HOME/$wallabag_sqldump_filename"

###############
# photoprism
###############
photoprism_sqldump_filename="photoprism-sqldump-$current_date.sql"

echo "photoprism..."
PHOTOPRISM_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=photoprism | tail -1 | awk '{print $1}')"
echo "$PHOTOPRISM_POD_NAME"
kubectl exec "$PHOTOPRISM_POD_NAME" -c photoprism -- photoprism backup -i - >"$HOME/$photoprism_sqldump_filename"

aws s3 cp --endpoint-url "$r2_endpoint" "$photoprism_sqldump_filename" "$backup_path_prefix/$photoprism_sqldump_filename"
rm "$HOME/$photoprism_sqldump_filename"

curl -d "Successfully backup DELL 🤩" ntfy.sh/kwdellbackup

###############
# forgejo
###############
### data
forgejo_backup_filename="forgejo-data-$current_date.tar.gz"

echo "forgejo data..."
tar -czf "$forgejo_backup_filename" /opt/forgejo/data

aws s3 cp --endpoint-url "$r2_endpoint" "$forgejo_backup_filename" "$backup_path_prefix/$forgejo_backup_filename"
rm "$HOME/$forgejo_backup_filename"

### db
forgejo_sqldump_filename="forgejo-sqldump-$current_date.psql"

echo "forgejo db..."
FORGEJO_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=forgejo-statefulset --namespace forgejo | tail -1 | awk '{print $1}')"
echo "$FORGEJO_POD_NAME"

# shellcheck disable=SC2034
PGPASSWORD=forgejopassword
kubectl exec --namespace forgejo "$FORGEJO_POD_NAME" -c postgres -- pg_dump -Fc -c -U forgejo >"$HOME/$forgejo_sqldump_filename"

aws s3 cp --endpoint-url "$r2_endpoint" "$forgejo_sqldump_filename" "$backup_path_prefix/$forgejo_sqldump_filename"
rm "$HOME/$forgejo_sqldump_filename"

########
# REMOVE OLD BACKUPS
########
aws s3api list-objects-v2 \
	--endpoint-url "$r2_endpoint" \
	--bucket "$bucket_name" \
	--output text \
	--query "Contents[?LastModified<= '$remove_backup_before_date'].[Key]" | xargs printf -- "s3://$bucket_name/%s\n" | xargs -L 1 aws s3 rm --endpoint-url "$r2_endpoint"
