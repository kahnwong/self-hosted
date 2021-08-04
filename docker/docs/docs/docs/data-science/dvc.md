---
title: DVC
---

https://dvc.org/doc/start

## Install
`brew install dvc`

## Init
```bash
# init
dvc init

# add storage backend remote
dvc remote add -d storage s3://dvc-playground/dvc-playground

# set aws profile
dvc remote modify storage profile ${AWS_PROFILE}

# commit changes
git commit .dvc/config -m "Configure remote storage"
```

## Usage
```bash
# create data dir and download file
mkdir -p data && wget -P data ${FILE_URL}

# checkin data via dvc
$ dvc add data/recent-stacks.csv # this creates $FILE.dvc
$ dvc push

# checkin dvc slug via git
$ git add data/recent-stacks.csv.dvc
$ git commit data/recent-stacks.csv.dvc -m "Dataset updates"
```

## CRUD
```bash
# pull data
dvc pull

# list checkin-ed files via dvc
dvc list https://github.com/baania/dvc-playground data

# download data from another repo
dvc get https://github.com/iterative/dataset-registry \
          use-cases/cats-dogs

# import file from another repo (can also fetch newer version from source)
dvc import https://github.com/iterative/dataset-registry \
             get-started/data.xml -o data/data.xml

## to update
dvc update
```

## Python API
`pip install dvc`

### Usage
```python
# get resource url
import dvc.api

resource_url = dvc.api.get_url(
    'get-started/data.xml',
    repo='https://github.com/iterative/dataset-registry')
# resource_url is now "https://remote.dvc.org/dataset-registry/a3/04afb96060aad90176268345e10355"

# load data
import pickle
import dvc.api

model = pickle.loads(
    dvc.api.read(
        'model.pkl',
        repo='https://github.com/example/project.git'
        mode='rb'
        )
    )
```