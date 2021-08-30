---
title: Folium
---

## Heatmap
```python
import json
import folium
from folium.plugins import HeatMap
import csv
coordinates = []

with open('hospitals.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    # next(reader, None) #skip first header
    # next(reader, None) #skip second header

    for row in reader: #loop each line
        try:
            lat = row['EP1_Latitude']
            # print(lat)
            lat = float(lat)
            lng = row['EP1_Longitude']
            # print(lng)
            lng = float(lng)
            geoloc = [lat, lng]
            coordinates.append(geoloc)
        except ValueError:
            pass

coordinates = coordinates#[:1000]
# print(coordinates)

bkk_coordinates = [13.736717, 100.523186]
m = folium.Map(bkk_coordinates, tiles='stamentoner', zoom_start=6)
HeatMap(coordinates).add_to(m)
m.save('hospital_thailand_heatmap.html')
```
