# cloudnativepg

## PostGIS Setup

```sql
-- run on target database
CREATE EXTENSION postgis;

-- grant access to postgis
GRANT USAGE ON SCHEMA public TO pguser;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE spatial_ref_sys TO pguser;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO pguser;

-- test query
SELECT ST_Distance(
    ST_GeomFromText('POINT(0 0)'),
    ST_GeomFromText('POINT(3 4)')
) AS test_distance;
```
