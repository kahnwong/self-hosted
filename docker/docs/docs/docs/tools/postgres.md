---
title: Postgres
---

## Administration
### Get activity log
```sql 
SELECT usename,datname,count(*) 
FROM pg_stat_activity 
GROUP BY usename,datname 
ORDER BY 3 DESC;
```

### List database/table names/size
```sql
-- list databases
SELECT datname FROM pg_database
WHERE datistemplate = false;

-- list tables in database
SELECT table_schema,table_name
FROM information_schema.tables
ORDER BY table_schema,table_name;

-- list table size
SELECT nspname || '.' || relname AS "relation", pg_total_relation_size(C.oid) as "total_size",
    pg_size_pretty(pg_total_relation_size(C.oid)) AS "total_size_pretty"
  FROM pg_class C
  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
    AND C.relkind <> 'i'
    AND nspname !~ '^pg_toast'
  ORDER BY pg_total_relation_size(C.oid) DESC
;

-- get database size
SELECT
     pg_size_pretty (
        pg_database_size ('dvdrental')
    );
```

### Get access permission
```sql
SELECT grantee, privilege_type 
FROM information_schema.role_table_grants 
WHERE table_name='mytable'
```

### Terminate process
```sql 
SELECT * FROM pg_stat_activity;

SELECT pg_terminate_backend(${PID});
```

### Grant permission
```sql 
-- admin
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO {ROLE};
-- readonly
GRANT SELECT ON all tables IN SCHEMA public TO {ROLE};
-- readonly-specific schema
GRANT SELECT ON {SCHEMA} TO {ROLE};
```

### Backup and restore
```bash 
# backup
$ pg_dump --host HOST --port 5432 --username USERNAME --format plain --verbose --file OUTFILE.sql --table public.TABLE_NAME DB_NAME
$ psql --host HOST --port 5432 --username USERNAME -d DB_NAME < BACKUP.sql

## another variant
# compression rate: 10x
$ pg_dump -Fc -c -h HOST -U USERNAME -d DB_NAME > OUTFILE.sql.gz
$ pg_restore -h HOST -U USERNAME -d DB_NAME -C -c BACKUP.sql.gz
```

## PSQL
```bash
# list column dtypes
\d+ city

# list indexes and size
\di+ {INDEX_PREFIX}*

# select database
\c {DB_NAME}

# login
psql -h HOST -d DB_NAME -U USER

# export to csv
psql -U user -d db_name -c "Copy (Select * From foo_table LIMIT 10) To STDOUT With CSV HEADER DELIMITER E'\t';" > foo_data.tsv

# export from pgcli
db> \copy (SELECT  * FROM district_boundary) TO '~/Downloads/file.tsv' WITH (FORMAT CSV, HEADER, DELIMITER E'\t')
```

## SQL
### CRUD
```sql
-- create table from SELECT
CREATE TABLE new_table
AS (SELECT * FROM old_table);

-- rename table
ALTER TABLE OG_NAME rename TO NEW_NAME;
```

### Syntax
```sql
-- cast string to datetime
TO_TIMESTAMP(date_created,'YYYY-MM-DD HH:MI:SS')

-- cast datetime to strong
to_char(timestamp_column, 'YYYY-MM')

-- timedelta
WHERE date_created < (NOW() - '3 months'::interval)::TEXT
```
