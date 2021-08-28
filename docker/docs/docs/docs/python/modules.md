---
title: Modules
---

## Use wheel
```
pip3 install --only-binary pandas sklearn numpy
```

## Pre-reqs for gcc on linux
```bash
RUN apt update
RUN apt-get install libssl-dev python3-dev gcc libc-dev libxml2-dev libxslt1-dev zlib1g-dev g++ -y
```

## Modules List
### CLI
`pip3 install topydo topydo[columns] youtube-dlc fava visidata pipenv`

### Data science
`pip3 install --only-binary pyspark==3.1.2 mlflow hyperopt numpy pandas sklearn jupyterlab seaborn matplotlib pytz`

### Databases
```
sqlalchemy
psycopg2-binary
pymongo
dnspython
```

### NLP
```
dateparser
langdetect
parsedatetime
fuzzywuzzy
python-dateutil
python-Levenshtein
```

### Scraping
```
beautifulsoup4
readability-lxml
requests
scrapy
selenium
```

### GIS
```
folium
geopandas-postgis
geopandas
```

### Auth
```
google-api-python-client
google-auth-oauthlib
google-auth-httplib2
```

### API client
```
pypandoc
boto3
```

### Misc
```
python-dotenv
tqdm
termcolor
flatten_json
```

### Visualizations
```
conda install plotly
jupyter labextension install @jupyterlab/plotly-extension
```
