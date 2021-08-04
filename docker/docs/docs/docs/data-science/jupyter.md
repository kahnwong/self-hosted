---
title: Jupyter
---

## Jupyter magic
### Set max  in-line rows / cols
```python
import pandas as pd
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)
```

### Auto refresh module
```python
%load_ext autoreload
%autoreload 2
```

## Read env from file
```python
%load_ext dotenv

# Use find_dotenv to locate the file
%dotenv
```

```python title="from specific file"
from dotenv import load_dotenv
load_dotenv()

from pathlib import Path  # Python 3.6+ only
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)
```

## Convert to markdown
```bash
jupyter nbconvert refugees_swe_jekyll.ipynb --to markdown
```

## Programatically generate notebook
```python
import nbformat
from nbformat.v4 import new_notebook, new_code_cell

def gen_notebook(source):
    nb = new_notebook()
    prep = """import pandas as pd
from collections import Counter
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline

df = pd.read_csv('{}.tsv', encoding='utf-8', sep='\\t')
df = df.where((pd.notnull(df)), None)""".format(source)

    function = """def viz_dtype(column_name):
    plt.style.use('ggplot')
    column_data = df[column_name].to_list()
    dtypes = [type(i).__name__ for i in column_data]

    labels, values = zip(*Counter(dtypes).items())
    x = labels
    y = values

    x_pos = [i for i, _ in enumerate(x)]

    colors = ["green" if i!='NoneType' else "red" for i in x]
    plt.bar(x_pos, y, color=colors)
    plt.title(column_name)
    plt.xticks(x_pos, x)

    plt.show()"""

    cells = [prep, function]

    # loop columns
    for column in columns:
        cells.append("""viz_dtype(\"{}\")""".format(column))


    for code in cells:
        nb.cells.append(new_code_cell(code))

    nbformat.write(nb, '{}.ipynb'.format(source))
```