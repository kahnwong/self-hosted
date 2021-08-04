---
title: Visualizations
---

## Init
```python
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()
sns.set(font="Tahoma")

# if using only matplotlib
plt.rcParams["font.family"] = "cursive"
```

## Usage
### Scatter / line plot
```python
fig = plt.figure(figsize=(10,6))

sns.scatterplot(x="time", y="yield_rate",
                hue='neighborhood',
                #  palette=cmap,
                data=temp)\
                .set_title('yield rate per period)
```

### Multiplot
```python
g = sns.FacetGrid(tips, col="time")
g.map(plt.hist, "tip");
```

### Rotate axis title
```python
plt.xticks(rotation=90)
```


## Recipes
### Plot dtype hist
```python
from collections import Counter

column_name = 'date_updated'
column_data = list(df[column_name].unique())
dtypes = [type(i).__name__ for i in column_data]

validating = [i for i in column_data if type(i).__name__=='str']
# validating

with open('values.txt', 'w') as f:
    f.writelines([str(i)+'\n' for i in validating])
######
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
plt.style.use('ggplot')

labels, values = zip(*Counter(dtypes).items())

x = labels
y = values

x_pos = [i for i, _ in enumerate(x)]

plt.bar(x_pos, y, color='green')
# plt.xlabel("Energy Source")
# plt.ylabel("Energy Output (GJ)")
# plt.title("Energy output from various fuel sources")

plt.xticks(x_pos, x)

plt.show()
```

### Stacked histogram
```python
import matplotlib.colors as colors

colors_list = list(colors._colors_full_map.values())

# colors_list = ['brown', 'gold', 'aqua', 'darkgreen', 'grey', 'blue', 'lime', 'olive', 'orange', 'red', 'salmon',]
fig = plt.figure(figsize=(10,6))

for index, artist_name in enumerate(df.artist.unique()):
    sns.distplot(df[df.artist==artist_name].word_count, color=colors_list[index+5], kde=False)

fig.legend(labels=df.artist.unique())
```

### Add label on point
```python
fig = plt.figure(figsize=(20,20))

for line in range(0,df.shape[0]):
     ax.text(df.sale_hat_y[line], df.yield_11m_y[line], df.district[line], horizontalalignment='center', size='medium', color='black', weight='semibold')
        
fig.savefig('scatter.png')
```

### Draw arrow from point a to b
```python
fig = plt.figure(figsize=(20,10))
for index, d in df.iterrows():
    plt.arrow(d['sale_hat_x'], d['yield_11m_x'], d['sale_hat_y']-d['sale_hat_x'], d['yield_11m_y']-d['yield_11m_x'], head_width=0.004, head_length=60000, color='r', linewidth=0.03) # , , length_includes_head=True
    plt.annotate(s=d['district'], xy=(d['sale_hat_y'], d['yield_11m_y']-0.003), color='g')
    
plt.scatter(df.sale_hat_x, df.yield_11m_x, color='green')
plt.scatter(df.sale_hat_y-60000, df.yield_11m_y, color='black')

plt.xlabel('sale_price')
plt.ylabel('yield_11m')
plt.ylim(0.02, 0.08)
plt.xlim(0,10065240)
```

### Mekko chart
```python
from random import random

df = df.sort_values(by='yield_change')

fig = plt.figure(figsize=(20,6))

data = df.yield_change
width = df.listing_count_y

l = df.listing_count_y.tolist()
tt = [0]
tt.extend(l[:-1])

left = []
c = 0
for i in tt:
    c+=i
    left.append(c)
    

fig = plt.figure(figsize=(30,10))
plt.bar(left, data, width , 
        alpha = 0.6, align='edge', edgecolor = 'k', linewidth = 2, color=[(random(), random(), random()) for i in range(len(df))])


# for index, d in df.iterrows():
for i, j, k in zip(left, data, df['district'].tolist()):
    y = j if j>0 else 0
    plt.annotate(s=k, xy=(i, y+0.0005), color='black', rotation=45)
    
plt.ylim(-0.007, 0.0075)
plt.xlim(0,300)
# plt.xlabel('listing_count')
plt.ylabel('yield_change')
```