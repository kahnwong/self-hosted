---
title: AWS
---

## Install
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

## Usage
```bash
# set config
aws configure

# upload to S3
aws s3 cp LOCAL s3://REMOTE_PATH

# download from s3
aws s3 cp s3://REMOTE_PATH output --recursive
```

## AWS S3
### Init
```python title="python"
from boto3.session import Session

session = Session(aws_access_key_id=ACCESS_KEY,
                  aws_secret_access_key=SECRET_KEY,
                  region_name='ap-southeast-1')

s3 = session.resource('s3')
client = s3.meta.client
```

### List files
```python title="python"
# list buckets
buckets = [i['Name'] for i in client.list_buckets()['Buckets']]

# list files inside buckets
files = client.list_objects_v2(Bucket=BUCKET_NAME)['Contents']
files = [i['Key'] for i in files]
```

```bash title="wildcard"
aws s3 cp s3://data/ . --recursive --exclude "*" --include "2016-08*"`
```

### CRUD
```python title="python"
# download
client.download_file(BUCKET_NAME, s3://BUCKET_NAME/FILENAME, LOCAL_PATH)

# upload
client.upload_file(LOCAL_PATH, BUCKET_NAME, FILENAME)

# delete
client.delete_object(Bucket=BUCKET_NAME, Key=FILENAME)

# move / rename
client.copy_object(Bucket=BUCKET_NAME, CopySource=BUCKET_NAME/FILENAME_OLD, Key=FILENAME_NEW)
client.delete_object(Bucket=BUCKET_NAME, Key=FILENAME_OLD)
```

### Sync
```bash
aws s3 sync s3://S3PATH/ . --dryrun
```

### Pandas
```python title="read"
import os
import s3fs
import pandas as pd

os.environ["AWS_ACCESS_KEY_ID"] = ACCESS_KEY
os.environ["AWS_SECRET_ACCESS_KEY"] = SECRET_KEY

df = pd.read_csv(S3PATH, sep='\t', na_values=r'\N')
```

```python title="write"
import os
import s3fs
import pandas as pd

os.environ["AWS_ACCESS_KEY_ID"] = ACCESS_KEY
os.environ["AWS_SECRET_ACCESS_KEY"] = SECRET_KEY

s3 = s3fs.S3FileSystem()

# Use 'w' for py3, 'wb' for py2
with s3.open(S3PATH,'w') as f:
    df.to_csv(f, sep='\t', index=False)
```

```python title="write to s3"
### prep data
content = ''
for item in job.items.iter():
    content+=json.dumps(item)
    content+='\n'

### init s3
s3 = boto3.resource(
    's3',
    region_name='ap-southeast-1',
    aws_access_key_id=os.environ['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key=os.environ['AWS_SECRET_ACCESS_KEY']
)

s3.Object('bn-data-dropoff', filename).put(Body=content)
```

```python title="write to s3 - binary"
import gzip
bytes_to_write = pairwise_final.to_csv(None, sep='\t', index=False)
compressed_value = gzip.compress(bytes(bytes_to_write, 'utf-8'))

client.put_object(  Bucket=BUCKET_NAME,
                Body=compressed_value,
                    Key='a/b.csv.gz'.format(proptype))
```

## AWS EMR
```bash
# also change checkpoint dir to "mnt/checkpoint"
spark-submit --py-files dist-matrix-module.zip  property_distance_matrix.py

# alternative
spark-submit --deploy-mode cluster s3://<PATH TO FILE>/sparky.py
```