#!/bin/bash
# https://developers.cloudflare.com/r2/examples/aws-cli/

current_date=$(date +%Y-%m-%d)
bucket_name="backup"
backup_path_prefix="s3://$bucket_name/$current_date"

# shellcheck disable=SC2154
r2_endpoint="https://$cloudflare_account_id.r2.cloudflarestorage.com"

cd "$HOME" || exit

###############
# photoprism
###############
kubectl config use-context nuc
photoprism_sqldump_filename="photoprism-sqldump-$current_date.sql"

echo "photoprism..."
PHOTOPRISM_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=photoprism | tail -1 | awk '{print $1}')"
echo "$PHOTOPRISM_POD_NAME"
kubectl exec "$PHOTOPRISM_POD_NAME" -c photoprism -- photoprism backup -i - >"$HOME/$photoprism_sqldump_filename"

aws s3 cp --endpoint-url "$r2_endpoint" --profile r2 "$photoprism_sqldump_filename" "$backup_path_prefix/$photoprism_sqldump_filename"
rm "$HOME/$photoprism_sqldump_filename"

curl -d "Successfully backup PHOTOPRISM" ntfy.sh/kwdellbackup

# ###############
# # forgejo
# ###############
# ### data
# forgejo_backup_filename="forgejo-data-$current_date.tar.gz"

# echo "forgejo data..."
# tar -czf "$forgejo_backup_filename" /opt/forgejo/data

# aws s3 cp --endpoint-url "$r2_endpoint" --profile r2 "$forgejo_backup_filename" "$backup_path_prefix/$forgejo_backup_filename"
# rm "$HOME/$forgejo_backup_filename"

# ### db
# forgejo_sqldump_filename="forgejo-sqldump-$current_date.psql"

# echo "forgejo db..."
# FORGEJO_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=forgejo-statefulset --namespace forgejo | tail -1 | awk '{print $1}')"
# echo "$FORGEJO_POD_NAME"

# # shellcheck disable=SC2034
# PGPASSWORD=forgejopassword
# kubectl exec --namespace forgejo "$FORGEJO_POD_NAME" -c postgres -- pg_dump -Fc -c -U forgejo >"$HOME/$forgejo_sqldump_filename"

# aws s3 cp --endpoint-url "$r2_endpoint" --profile r2 "$forgejo_sqldump_filename" "$backup_path_prefix/$forgejo_sqldump_filename"
# rm "$HOME/$forgejo_sqldump_filename"
