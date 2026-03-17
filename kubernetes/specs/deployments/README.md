# Deployments

## Postgres Restore

```bash
# exec backup job, then
date="2026-03-17"
service="foo"
r2 s3 cp . "s3://backup/$date/$service-sqldump-$date.bin"
cat "$service-sqldump-$date.bin" | kubectl exec -i "$service-postgres-0" -- pg_restore -U "$service" -d "$service"
```
