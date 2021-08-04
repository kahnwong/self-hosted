---
title: PySpark
slug: /
---

## Install
:::info
make sure pyspark version is same as spark version
:::

```bash
brew install apache-spark
pip3 install pyspark
```


### Test snippet
```python
from pyspark import SparkContext, SparkConf

sc = SparkContext.getOrCreate()

import numpy as np

TOTAL = 100000
dots = sc.parallelize([2.0 * np.random.random(2) - 1.0 for i in range(TOTAL)]).cache()
print("Number of random points:", dots.count())

stats = dots.stats()
print('Mean:', stats.mean())
print('stdev:', stats.stdev())

%matplotlib inline
from operator import itemgetter
from matplotlib import pyplot as plt

plt.figure(figsize = (10, 5))

# Plot 1
plt.subplot(1, 2, 1)
plt.xlim((-1.0, 1.0))
plt.ylim((-1.0, 1.0))

sample = dots.sample(False, 0.01)
X = sample.map(itemgetter(0)).collect()
Y = sample.map(itemgetter(1)).collect()
plt.scatter(X, Y)

# Plot 2
plt.subplot(1, 2, 2)
plt.xlim((-1.0, 1.0))
plt.ylim((-1.0, 1.0))

inCircle = lambda v: np.linalg.norm(v) <= 1.0
dotsIn = sample.filter(inCircle).cache()
dotsOut = sample.filter(lambda v: not inCircle(v)).cache()

# inside circle
Xin = dotsIn.map(itemgetter(0)).collect()
Yin = dotsIn.map(itemgetter(1)).collect()
plt.scatter(Xin, Yin, color = 'r')

# outside circle
Xout = dotsOut.map(itemgetter(0)).collect()
Yout = dotsOut.map(itemgetter(1)).collect()
plt.scatter(Xout, Yout)
```

## Init
```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when, lit, coalesce
from pyspark.sql.types import StructType, StructField, IntegerType, DoubleType, StringType, TimestampType
from pyspark.sql.window import Window
import pyspark.sql.functions as F

spark = SparkSession \
    .builder \
    .appName("Pyspark playground") \
    .config("spark.hadoop.fs.s3a.access.key", KEY) \
    .config("spark.hadoop.fs.s3a.secret.key", SECRET) \
    .config("spark.executor.memory", "4g") \
    .config("spark.driver.memory", "4g") \
    .getOrCreate()

# set config after spark session is created
spark_session.conf.set("spark.executor.memory", '8g')

spark.sparkContext.setLogLevel('ERROR')
spark.sparkContext.setCheckpointDir('checkpoint') # [DEBUG]
```

### Add JARs at runtine
```python
import os

os.environ['PYSPARK_SUBMIT_ARGS'] = '--packages "org.apache.hadoop:hadoop-aws:2.7.3" pyspark-shell'
```

## I/O
### CSV / TSV
```python
project_file = '/Users/kahnwong/Git/dmp_new/s3_to_db/property/project.tsv'

### read
project = spark.read.csv(
    project_file,
    header='true',
    inferSchema='true',
    sep="\t",
    nullValue=r'\N',
    timestampFormat="yyyy-MM-dd HH:mm:ss"
)

### write
spark.write.csv(output_path, header=True)
```

### JSON
```python
# read
spark.read.json("data/DMP_HIVE/all_listing.json") # add .option("multiLine", True) for multi-line

# write
spark.write.json(OUTPATH, compression='gzip')
```

## DataFrame
```python
# Describe DataFrame
project.printSchema() # .columns(), .dtypes(), describe() also exist

# Select columns
project.select(['project_id', 'name_th', 'area_total', 'price_min', 'price_max']).show()

# Rename columns
project.select(['project_id', 'name_th', 'area_total', 'price_min', 'price_max'])\
        .withColumnRenamed("name_th", "project_name")\
        .withColumnRenamed("price_min", "project_price_min")\
        .withColumnRenamed("price_max", "project_price_max")

# sampling
df.sample(False, sampling_percentage, seed=0)

# count records
project_unittype.count()

# converstion to pandas / pyspark
spark_df.toPandas() # spark to pandas
spark_session.createDataFrame(df_pd) # pandas to spark

# show in vertical
df.show(n=3, truncate=False, vertical=True)

# to list
df.select('listing_bed').toPandas()['listing_bed'].tolist()
```

### Transformation
```python
# casting
data_df.withColumn("drafts", data_df["drafts"].cast(IntegerType()))
df.withColumn('test', F.from_unixtime(df.create_date / 1000)).select('test') # epoch to timestamp
F.to_date('listing_update') # timestamp to date
df.withColumn('datetime_cst', F.from_utc_timestamp('datetime_utc', 'CST')).show() # utc to tz

# combine cols to array
df.withColumn('combined', F.array('x_1', 'x_2')).show()

# combine values from multiple rows via groupby
df.where(col('page')=='project')\
    .groupBy('fingerprint')\
        .agg(F.collect_list('eid2').alias('view_projects'))\
    .select('fingerprint view_projects'.split())\
.show()

# fillna with another column
.withColumn('t', coalesce('field_property_project','project_name'))

# create new column with max value from set of columns
a.withColumn(“max_col”, greatest(a[“one”], a[“two”], a[“three”]))

# add null columns
df.withColumn(col_name, lit(None).cast(col_type))

# regex matching --> longest maching works if longest regex is at the start
.withColumn('name_th',regexp_replace(trim(lower(col('name_th'))), string_clean_regex, ''))\

# find median
df_spark.approxQuantile(df_spark.columns, [0.5], 0.25)

# select elem by name from array column
df2\
    .withColumn('post_date_bp', F.col('post_date_bp')['$date'])\
    .withColumn('scrape_date', F.col('scrape_date')['$date'])\
    .select('post_date_bp', 'scrape_date')\
    .show()

## by index
df2\
    .withColumn('post_date_bp', F.col('post_date_bp').getItem(0))\
    .withColumn('scrape_date', F.col('scrape_date').getItem(0))\
    .show()

# Join
project\
    .join(
        unittype, 
        ['project_id'], # project.project_id == unittype.project_id in case keys are different, otherwise [COL_NAME] to prevent column duplicates
        how='left')

# Explode array
df = df\
        .withColumn("tmp", F.explode("tmp"))\
        .select(*df.columns, 
            col("tmp.temp_property_type_title_th").alias("propertytype_name_th"),
            col("tmp.temp_property_type_title_en").alias("propertytype_name_en"),
            col("tmp.temp_property_type_id").alias("propertytype_id"))

# get percentile
df.approxQuantile(['Apple', 'Oranges'],[0.1, 0.25, 0.5, 0.75, 0.9, 0.95],0.1)

# create boolean column from regex matching
df.withColumn(
    'matched',
    F.when(df.email.rlike('^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$'), True)\
        .otherwise(False))
```

## Cookbook
### Count missing values  + groupby
``` python
from pyspark.sql.functions import count, abs

# df_missing = df_temp.groupBy("a", "b").agg(
#                                         (count("*") - count('d')).alias('d'),
#                                         (count("*") - count('e')).alias('e'),
#                                         (count("*") - count('f')).alias('f'),
#                                                         )

from pyspark.sql.functions import isnan, when, count, col

df.select([count(when(col(c).isNull(), c)).alias(c) for c in df.columns]).show(vertical=True)
```

### Filter by order
```python
from pyspark.sql.window import Window


w = Window().partitionBy('fingerprint').orderBy(F.desc('timestamp'))

df_mapping = df.where(col('uid2').isNotNull())\
    .withColumn('fingerprint_rank', F.row_number().over(w))\
    .filter(col('fingerprint_rank') == 1)\
        .drop(col('fingerprint_rank'))\
    .selectExpr('uid2 as uid_impute', 'fingerprint').cache()

df_mapping.show()
```

### Skew join optimization
https://stackoverflow.com/a/57951114

```python
from math import exp
from random import randint
from datetime import datetime

def count_elements(splitIndex, iterator):
    n = sum(1 for _ in iterator)
    yield (splitIndex, n)

def get_part_index(splitIndex, iterator):
    for it in iterator:
        yield (splitIndex, it)

num_parts = 18
# create the large skewed rdd
skewed_large_rdd = sc.parallelize(range(0,num_parts), num_parts).flatMap(lambda x: range(0, int(exp(x))))
skewed_large_rdd = skewed_large_rdd.mapPartitionsWithIndex(lambda ind, x: get_part_index(ind, x))
skewed_large_df = spark.createDataFrame(skewed_large_rdd,['x','y'])

small_rdd = sc.parallelize(range(0,num_parts), num_parts).map(lambda x: (x, x))
small_df = spark.createDataFrame(small_rdd,['a','b'])

## prep salts
salt_bins = 100
from pyspark.sql import functions as F

skewed_transformed_df = skewed_large_df.withColumn('salt', (F.rand()*salt_bins).cast('int')).cache()

small_transformed_df = small_df.withColumn('replicate', F.array([F.lit(i) for i in range(salt_bins)]))
small_transformed_df = small_transformed_df.select('*', F.explode('replicate').alias('salt')).drop('replicate').cache()

## magic happens here
t0 = datetime.now()
result2 = skewed_transformed_df.join(small_transformed_df, (skewed_transformed_df['x'] == small_transformed_df['a']) & (skewed_transformed_df['salt'] == small_transformed_df['salt']) )
result2.count() 
print "The direct join takes %s"%(str(datetime.now() - t0))
```

## Optimization  
### Caching
[More details](https://stackoverflow.com/questions/26870537/what-is-the-difference-between-cache-and-persist)

:::info
Improves read performance for frequently accessed DataFrame
:::

```python
df.cache()

# clear cache
spark.catalog.clearCache()
```

### Repartition + partition data
```python
df.repartition(4)
df.write \
    .partitionBy(*partition_columns) \
    .parquet(base_path, mode=write_mode)
```

### Dynamic partition write mode
```python
'''
Note: Why do we have to change partitionOverwriteMode?
Without config partitionOverwriteMode = 'dynamic', Spark will
overwrite all partitions in hierarchy with the new
data we are writing. That's undesirable and dangerous.
https://stackoverflow.com/questions/42317738/how-to-partition-and-write-dataframe-in-spark-without-deleting-partitions-with-n
Therefore, we will temporarily use 'dynamic' within the context of writing files to storage.
'''
partitionOverwriteMode_before = spark.conf.get('spark.sql.sources.partitionOverwriteMode')
log.info("(before) partitionOverwriteMode: {}".format(partitionOverwriteMode_before))
if partitionOverwriteMode_before != 'dynamic':
    log.info("Temporarily set partitionOverwriteMode to 'dynamic'")
    spark.conf.set('spark.sql.sources.partitionOverwriteMode', 'dynamic')

### repartition/coalesce dataframe based on num_partitions
df = repartition_coalesce(df, num_partitions)

### write partitioned dataframe to Storage
partition_columns = [item[0] for item in self.partitions]
log.info("write_mode: {}".format(write_mode))
base_path = write_retry_loop(df, partition_columns, write_mode, max_retry, wait_seconds_before_next_retry, override_base_path)

### restore partitionOverwriteMode to its original
if partitionOverwriteMode_before != 'dynamic':
    log.info("Restore partitionOverwriteMode to '{}'".format(partitionOverwriteMode_before))
    spark.conf.set('spark.sql.sources.partitionOverwriteMode', partitionOverwriteMode_before)
```

## JDBC Interfaces
### MySQL
```python
table = """(SELECT id, 
        person, 
        manager, 
        CAST(tdate AS CHAR) AS tdate, 
        CAST(start AS CHAR) AS start, 
        CAST(end AS CHAR) as end, 
        CAST(duration AS CHAR) AS duration 
    FROM EmployeeTimes) AS EmployeeTimes""",

spark = get_spark_session()
df = spark.read.format("jdbc"). \
    options(url=f"jdbc:mysql://{host}:3306/{db_name}",
            driver='com.mysql.jdbc.Driver',
            dbtable=table,
            user=username,
            password=password).load()
return df
```

### Postgres
```python
df = spark.read.format("jdbc") \
    .option("url", "jdbc:postgresql://{}:5432/{}".format(host, db_name)) \
    .option("query", query) \
    .option("user", username) \
    .option("password", password) \
    .option("driver", "org.postgresql.Driver") \
    .load()
```

### Oracle
```python
table_name = "(SELECT ACTIONCOLOR FROM xininsure.action) tmp"

df = spark.read\
        .format("jdbc") \
        .option("url", "jdbc:oracle:thin:@//{}:{}/{}".format(
            os.environ['HOST'], 
            os.environ['PORT'], 
            os.environ['SID'])) \
        .option("dbtable", table_name) \
        .option("user", os.environ['USER']) \
        .option("oracle.jdbc.timezoneAsRegion", "Asia/Bangkok") \
        .option("password", os.environ['PASSWORD']) \
        .option("driver", "oracle.jdbc.OracleDriver") \
        .load()
```

### MongoDB
```python
import os
os.environ['PYSPARK_SUBMIT_ARGS'] = '--packages "org.mongodb.spark:mongo-spark-connector_2.11:2.4.2" pyspark-shell'

from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("myApp") \
    .config("spark.mongodb.input.uri", "mongodb://USER:PASSWORD@HOST:27017/DB.COLLECTION?authSource=admin&readPreference=primary&ssl=false") \
    .config("spark.mongodb.input.uri", "mongodb://USER:PASSWORD@HOST:27017/DB.COLLECTION?authSource=admin&readPreference=primary&ssl=false") \
    .getOrCreate()
```

## JDBC write
### Write to db
:::info
To overwrite without losing schema & permission, use `truncate`
:::

```python
df.write \
    .format("jdbc") \
    .option("url", "jdbc:postgresql://{}:5432/{}".format(host, db_name)) \
    .option("dbtable", table_name) \
    .option("user", username) \
    .option("password", password) \
    .option("driver", "org.postgresql.Driver") \
    .option("truncate", "true") \
    .mode("overwrite") \
    .save()
```

### Override schema
```python
column_types = ', '.join(['{} VARCHAR(4000)'.format(i)
                              for i in string_cols])
option("createTableColumnTypes", column_types) \
```


## spark-submit
```bash
spark-submit --conf spark.driver.memory=25gb --executor-memory 13g --num-executors 50 --driver-memory 20g FILE.PY

spark-submit --conf maximizeResourceAllocation=true FILE.PY
```

## Misc
```bash
# get spark location
echo 'sc.getConf.get("spark.home")' | spark-shell
```