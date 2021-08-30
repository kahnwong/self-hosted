---
title: Sklearn
---

## Visualize dataset cluster via t-nse
```python
from sklearn.manifold import TSNE
import seaborn as sns

import warnings
warnings.simplefilter(action='ignore')

#####################
for i in categ_columns:
    df[i] = df[i].astype('category').cat.codes

tsne = TSNE()
X_embedded = tsne.fit_transform(df[numer_columns])

#####################
sns.set(rc={'figure.figsize':(11.7,8.27)})
sns.scatterplot(X_embedded[:,0], X_embedded[:,1], hue=df['PACKAGENAME'], legend='full')
```

## Model training using linux
1. Install Ubuntu subsystem on Windows
2. Update repo by running `sudo apt update`
3. `python3` is preinstalled on Linux, but `pip` isn't, so run `sudo apt install python3-pip` and select `y`
4. Install modules via `pip3 install pandas numpy sklearn`
5. Create a text file via nano `FILE.py` and type in:
   ```python
    import numpy as np
    from sklearn.naive_bayes import GaussianNB

    X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
    Y = np.array([1, 1, 1, 2, 2, 2])

    clf = GaussianNB()
    clf.fit(X, Y)

    ### save model artifact
    import joblib

    joblib.dump(MODEL, FILENAME)
   ```
6. Run with `python3 FILE.py`
