# Database

## Postgres Restore

Scale deployments to `0` before running a database restore.

If it hangs at `pg_restore: warning: errors ignored on restore: 2099`, you can ignore since the tty just hangs.

```bash
# exec backup job, then
export date="2026-03-17"
export service="foo"
export dbname="foo"
r2 s3 cp "s3://backup/$date/$service-sqldump-$date.bin" .
cat "$service-sqldump-$date.bin" | kubectl exec -i "$service-postgres-0" -- pg_restore -U "$service" -d "$dbname" --clean -v
```

If you want to run a manual backup job:
```bash
kubectl exec <pod-name> -- pg_dump -U <username> -d <db-name> -Fc > backup_file.bin
```
