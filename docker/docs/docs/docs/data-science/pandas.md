---
title: Pandas
---

## I/O
```python
### read json in pandas
pd.read_json(FILENAME)

### read in chunk
for index, chunk in enumerate(pd.read_csv(i, chunksize=chunksize)):
    print(print('======= #{} ======='.format(i)))
    df = chunk

### quote string in csv
import csv
pd.DataFrame(d).to_csv('debug.csv', quoting=csv.QUOTE_NONNUMERIC)

### convert to bytes
df.to_csv(index=False).encode()

### read sample dataset
df = pd.read_csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv')
```

### Save Excel worksheets
```python
import pandas as pd

df1 = pd.DataFrame({'Data': ['a', 'b', 'c', 'd']})
df2 = pd.DataFrame({'Data': [1, 2, 3, 4]})
df3 = pd.DataFrame({'Data': [1.1, 1.2, 1.3, 1.4]})

writer = pd.ExcelWriter('multiple.xlsx', engine='xlsxwriter')
df1.to_excel(writer, sheet_name='Sheeta')
df2.to_excel(writer, sheet_name='Sheetb')
df3.to_excel(writer, sheet_name='Sheetc')

writer.save()
```

## Ignore warnings
```python
from pandas.errors import DtypeWarning
from pandas.core.common import SettingWithCopyWarning
import warnings

warnings.simplefilter(action='ignore', category=DtypeWarning)
warnings.simplefilter(action='ignore', category=SettingWithCopyWarning)
```

## DataFrame
### Styling
```python
def color_negative_red(val):
    """
    Takes a scalar and returns a string with
    the css property `'color: red'` for negative
    strings, black otherwise.
    """
    color = 'red' if not val else 'white'
    return 'background-color: %s' % color

df.T.style.applymap(color_negative_red)
```

### Filter
```python
#filter two conditions
df[(df['CARCC'] >= 1000) & (df['CARCC'] <=3300 )]

# filter where categorical count is less than / greater than x
df[df.groupby("CARBRAND")['CARBRAND'].transform('size') >= 10]

# filter by list of values
df[df['A'].isin([3, 6])]
```

### String
```python
# assign array(in concat string format) to multiple column
df[['sentiment', 'weight']] = df['y'].str.split(', ', expand=True)

# strip whitespaces from pandas
pd.read_csv('project.csv', sep=',').apply(lambda x: x.str.strip() if x.dtype == "object" else x)

# strip string in string columns
df[df_obj.columns] = df_obj.apply(lambda x: x.str.strip())
```

### Join
```python
home_accr = home_accrs[0].join(home_accrs[1:]) # chain join

region.assign(key=1)\ ## cartesian cross-join
    .merge(property_type.assign(key=1), on="key")\
    .drop("key", axis=1)
```

### Apply function
```python
## apply lambda
df_page_paths[df_page_paths['pagePath'].apply(lambda x: '?' in x and x[:2] != '/?')]

## apply where IN=2 col and OUT=2 col
def rule(row):
    lat, lon = utm.to_latlon(row["X"], row["Y"], 45, 'K')
    return pd.Series({"lat": lat, "long": long})
df.merge(df.apply(rule, axis=1), left_index= True, right_index= True)

## another example
df.apply(lambda x: my_test(x['a'], x['c']), axis=1)
```

### Dtype casting
```python
# cast to numeric
subject_info['price_min'].apply(pd.to_numeric, errors='coerce')

# datetime
pd.to_datetime(raw_data['Mycol'], format='%d%b%Y:%H:%M:%S.%f')

df_lead['BIRTHDATE'] = pd.to_datetime(df_lead['BIRTHDATE'], infer_datetime_format=True)
```

## SQLAlchemy
```python
from sqlalchemy import create_engine, Index

engine = create_engine(
     'postgresql+psycopg2://USER:PASSWORD@HOST/DB_NAME')

df.to_sql(name=table_name, con=engine, index_label='idx', if_exists='append',
                  chunksize=chunksize, method='multi')

# note: if query has % replace it with %%
df = pd.read_sql(sql, cnxn)

df = psql.read_sql(('select "Timestamp","Value" from "MyTable" '
                     'where "Timestamp" BETWEEN %(dstart)s AND %(dfinish)s'),
                   db,params={"dstart":datetime(2014,6,24,16,0),"dfinish":datetime(2014,6,24,17,0)},
                   index_col=['Timestamp'])
```

## Visualizations
```python
columns = list(df_area_usable_accr)
color = [ 'b' for i in columns]
#highlight usa:
# color[ country_names.index("usa") ] = "b"
#highlight canada:

color[columns.index("mean_accr_unittype") ] = "r"
color[columns.index("median_accr_unittype") ] = "r"

df_area_usable_accr.iloc[0].plot(kind='barh', title='area_usable accr for home (more is better)', color=color, xlim=(0.75, 0.86))

## another example
law_count.plot.line(x='scrape_period', y='count', rot=90)

### template
import matplotlib.pyplot as plt

gdf.plot(figsize=(50,45)).get_figure().savefig('hello.png')
```

## Recipes
### Get null count for each column
```python
df = df.replace(0, np.nan)
counts = df.apply(lambda x: x.isnull().value_counts()).T
counts.columns = ['not null', 'null']
counts = counts[['not null']]
counts = counts[counts['not null'] >= 1000]
counts
```

### Split column w multiple values to separate rows
```python
# https://www.mikulskibartosz.name/how-to-split-a-list-inside-a-dataframe-cell-into-rows-in-pandas/

data.ingredients.apply(pd.Series) \
    .merge(data, right_index = True, left_index = True) \
    .drop(["ingredients"], axis = 1) \
    .melt(id_vars = ['cuisine', 'id'], value_name = "ingredient") \
    .drop("variable", axis = 1) \
    .dropna()
```

### Group by & get max value-rows only
```python
df_out = df[df['ratio'] == df.groupby(['comp_string1'])[
        'ratio'].transform(max)]

df.groupby('project_name')['similarity_score'].nlargest(10)
```

### Fill na from another column
combining two columns

```python
df.bar.combine_first(df.foo)
df['bar'] = np.where(pd.isnull(df['bar']),df['foo'],df['bar'])
```
