---
title: GDAL
---

## Convert shapefile to CSV
```bash
ogr2ogr -f CSV OUTPUT.csv INPUT.shp -nlt MULTIPOLYGON -lco GEOMETRY=AS_WKT -lco SEPARATOR=TAB
```
