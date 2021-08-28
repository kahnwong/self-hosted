---
title: Database
---

## psycopg2

### Usage
```python
import psycopg2
from psycopg2.extras import RealDictCursor

"""Init PostGIS"""
conn = psycopg2.connect(
            host="", dbname="", user="", password="")
cur = conn.cursor(cursor_factory=RealDictCursor)

cur.execute("""
                SELECT *
                FROM data
                LIMIT 100;
                """)
on_sale_raw = [i for i in cur]

cur.close()
conn.close()
```

### Batch inserts
```python
conn, cur = connect_postgis()
insert_statement = "INSERT INTO {} (id, value) VALUES %s ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value".format(table)
values = df.values.tolist()
psycopg2.extras.execute_values(cur, insert_statement, values)

conn.commit()
cur.close()

print('Successfully pushed to {}'.format(table))
```

## Pymongo
### Incremental export
```python
# init connection
client = pymongo.MongoClient(os.environ['hostname'], int(os.environ['port']))
client.admin.authenticate(
    os.environ['username'], os.environ['password'], mechanism='SCRAM-SHA-1')

# list databases
dbs = client.list_database_names()

# list collections in database
db = 'DMP_HIVE'
collections = client[db].list_collection_names()

# get data
for collection_name in sorted(collections):
    output_dir = f'data/{db}'
    filename =  f'{output_dir}/{collection_name}.jl'
    collection = client[db][collection_name]

    print(f'processing {filename}')

    os.makedirs(output_dir, exist_ok=True)
    cursor = collection.find({})
    total_records = collection.estimated_document_count()

    with open(filename, 'w') as f:
        for i in tqdm(cursor, total=total_records):
            f.write(json.dumps(i, default=myconverter, ensure_ascii=False))
            f.write('\n')

    # break
```
