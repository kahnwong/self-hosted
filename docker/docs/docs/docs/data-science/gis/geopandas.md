---
title: GeoPandas
---

## I/O
### Create gpd from df
```python
import pandas as pd
import geopandas as gpd
from shapely.geometry import Point

project = pd.read_csv('project.csv').dropna(subset=['latitude'])
project

geometry = [Point(xy) for xy in zip(project.longitude, project.latitude)]
crs = {'init': 'epsg:4326'}
project = gpd.GeoDataFrame(project, crs=crs, geometry=geometry)
```

### Change projection
```python
gdf.to_crs("epsg:3395")
```

### Write to file
```python
.to_file("foodpanda.geojson", driver='GeoJSON')
```

### Write gpd to postgres
```bash title="prerequisites"
pip install pyarrow

# https://gis.stackexchange.com/questions/239198/adding-geopandas-dataframe-to-postgis-table
pip install psycopg2-binary
pip install sqlalchemy
pip install geoalchemy2
pip install geopandas
```

```python title="usage"
import geopandas
from sqlalchemy import create_engine
from shapely.wkt import loads as wkt_to_geom

# Set up database connection engine
engine = create_engine('postgresql://{}:{}@{}:5432/{}'.format(DB_USERNAME, DB_PASSWORD, DB_HOSTNAME, DB_NAME))

# Load data into GeoDataFrame, e.g. from shapefile
geodata = gpd.GeoDataFrame(df)
geodata['geometry'] = geodata['geom'].apply(lambda x: wkt_to_geom(x))

# GeoDataFrame to PostGIS
geodata.to_postgis(
    con=engine,
    name="boundary_test_write"
)
```

## Find nearest point
```python
from shapely.ops import nearest_points

nearest = project.geometry == nearest_points(
    Point(100.5197637498, 13.8590163404),
    project.geometry.unary_union)\
    [1]

project[nearest]
```

## Make square grid
```python
import geopandas as gpd
import numpy as np
from shapely.geometry import Polygon

############

urban = gpd.read_file('urban_175m.shp')
xmin,ymin,xmax,ymax = urban.total_bounds

length = 0.00157
width = 0.00157

# cols = list(range(int(np.floor(xmin)), int(np.ceil(xmax)), wide))
cols = np.arange(xmin, xmax, length).tolist()
# rows = list(range(int(np.floor(ymin)), int(np.ceil(ymax)), lenght))
rows = np.arange(ymin, ymax, width).tolist()
rows.reverse()

polygons = []
for x in cols:
    for y in rows:
        polygons.append( Polygon([(x,y), (x+wide, y), (x+wide, y-lenght), (x, y-lenght)]) )

g = gpd.GeoDataFrame(
    {"data1": list(range(len(polygons))), "data2": list(range(10, 10+len(polygons)))},
    geometry=polygons,
    crs={"init": "epsg:4326"}
)
g.to_file("temp.shp")
```
