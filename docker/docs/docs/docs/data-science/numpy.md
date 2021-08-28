---
title: NumPy
---

## Generate numbers
```python
# int
>>> np.random.randint(1000000, 1100000, size=3)
array([1060285, 1097394, 1024292])

# float
>>> np.random.uniform(low=0.5, high=3.5, size=(50,))
```

## Randomly introduce np.nan
```python
def generate_array_with_random_nan(lower_bound, upper_bound, size):
    a = np.random.randint(lower_bound, upper_bound+1, size=size).astype(float)
    mask = np.random.choice([1, 0], a.shape, p=[.2, .8]).astype(bool)
    a[mask] = np.nan

    return a
```
