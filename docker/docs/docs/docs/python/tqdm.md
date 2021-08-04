---
title: tqdm
---

## Usage

```python
from tqdm import tqdm
for i in tqdm(range(10000)):
    pass
```

### with read_csv chunksize
```python
data_reader = pd.read_csv(filepath, chunksize=chunksize, sep='\t')
total_records = sum(1 for row in open(filepath, 'r'))

for chunk in tqdm(data_reader, total=int(total_records/chunksize)):

    # print('\t\t# {}'.format(str(index)))
    df = chunk
```