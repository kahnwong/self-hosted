---
title: References
---

## Spatial projection
| ESPG Code  | Projection                      | Unit   |
| ---------- | ------------------------------- | ------ |
| ESPG:4240  | THAILAND                        | Degree |
| ESPG:4326  | WGS84                           | Degree |
| EPSG:3857  | GOOGLE                          | Meter  |
| ESPG:32647 | WGS84 / UTM zone 47N - THAILAND | Meter  |


## BMA zone
- กรุงเทพมหานคร
- นครปฐม
- นนทบุรี
- ปทุมธานี
- สมุทรปราการ
- สมุทรสาคร

## Degree / meter conversion
```python
KM = DEGREE * 111.319
DEGREE = KM / 111.319
```

### Example
 ```
15 km = 0.135 degree
10 km = 0.09 degree
6 km = 0.054 degree
4 km = 0.036 degree
3 km = 0.027 degree
```
