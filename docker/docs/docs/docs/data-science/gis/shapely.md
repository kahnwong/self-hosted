---
title: Shapely
---

## WKB to WKT
```python
from shapely import wkb

hexloc="0101000020E610000072604C0D47AA37402C306475ABA85140"
hexloc=df['geom'][0]
print(hexloc)

point=wkb.loads(hexloc,hex=True)
# print(point.x,point.y)

>>> point.to_wkt()
'POINT (23.6651466666666650 70.6354650000000106)'
```

## String to WKT
```python
import shapely.wkt

P = shapely.wkt.loads('POLYGON ((51.0 3.0, 51.3 3.61, 51.3 3.0, 51.0 3.0))')
print(P)
```