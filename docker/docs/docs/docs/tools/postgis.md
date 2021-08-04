---
title: PostGIS
---

## Initialize
`CREATE EXTENSION postgis;`

## SQL
### Add GEOM column
uses `ST_GeomFromText` for `WKT`

```sql
ALTER TABLE province ADD COLUMN geom geometry(Point, 4326);

UPDATE province
SET geom = ST_SetSRID(
    ST_MakePoint(
        cast(longitude AS DOUBLE PRECISION), 
        cast(latitude AS DOUBLE PRECISION)
        ), 
    4326)
WHERE latitude IS NOT NULL AND longitude IS NOT NULL;
```

### Cast projection unit to meter
```sql
ST_Distance(
    geom::geography, 
    ST_MakePoint(100.5257413,13.7338892)::geography) <= 3000
```

### Find polygon from point
```sql
-- single point
SELECT *
FROM province 
WHERE ST_DWithin(ST_SetSRID(ST_POINT(100.5858333,13.7422222),4326)::geography, geom,0);

--- against another table
SELECT *
FROM project_spatial
JOIN province
ON ST_WITHIN(hotel.geom, province.geom)
LIMIT 10;
```

### Find distance betwee x & y
unit depends on projection, in which `WGS4826` is `meter`

```sql
ST_Distance(
    the_geom::geography, 
    ST_MakePoint(100.5257413,13.7338892)::geography) 
AS distance_from_holy_land
```

### Count points in polygon
```sql
SELECT grid.gid, count(kioskdhd3.geom) AS totale 
FROM grid LEFT JOIN kioskdhd3 
ON st_contains(grid.geom,kioskdhd3.geom) 
GROUP BY grid.gid;
```

### Find nearest point from another table
```sql title="no distance limit"
SELECT test_spatial_performance.listing_listing_id, test_spatial_performance.project_name_th,
    (
        SELECT project.name_th
        FROM project
        ORDER BY test_spatial_performance.geom <#> project.geom LIMIT 1
    )
FROM test_spatial_performance
WHERE test_spatial_performance.project_name_th IS NOT NULL
LIMIT 10;
```

```sql title="with distance limit"
SELECT
    test_spatial_performance.listing_listing_id, project.project_name_th
FROM test_spatial_performance
CROSS JOIN LATERAL
    (
        SELECT project_name_th,
        ST_Distance(test_spatial_performance.geom, project.geom) AS dist
        FROM project
        WHERE ST_DWithin(test_spatial_performance.geom, project.geom, 200)
        ORDER BY ST_Distance(test_spatial_performance.geom, project.geom)
     LIMIT 1


    ) AS project
WHERE project.project_name_th IS NOT NULL
LIMIT 50;
```