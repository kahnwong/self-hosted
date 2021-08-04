---
title: Scrapy
---


## Spider
```python
import scrapy

class SampleSpider(scrapy.Spider):
    name = "sample"

    start_urls = ['a', 'b', 'c']

    def parse(self, response):
        # parse here

        yield i
```

### Override / add settings
```python
custom_settings = {
        'SOME_SETTING': 'some value',
    }
```

## Make requests
### GET
```python
yield scrapy.Request(
    url=url,
    cookies=cookies,
    callback=self.add_coordinates,
    meta={'data': j}
    )
```

```python title="formdata"
yield scrapy.FormRequest(
    url=url,
    method='GET',
    dont_filter=True,
    formdata=payload,
    meta={
        'facetFilters': facetFilter,
        'numericFilters': numericFilter
    },
    callback=self.get_each_page)
```

### POST
```python
yield scrapy.Request(url=start_url,
    method='POST',
    body=json.dumps(payload),
    headers={'Content-Type':'application/json'},
    callback=self.get_cities
)
```

```python title="formdata"
yield scrapy.FormRequest(
    'api.example.com', 
    callback=self.parse,
    method='POST', 
    formdata=params
)
```

## Pipelines
### Write as single-line JSON
```python
import json

from itemadapter import ItemAdapter

class JsonWriterPipeline:

    def open_spider(self, spider):
        self.file = open('items.jl', 'w')

    def close_spider(self, spider):
        self.file.close()

    def process_item(self, item, spider):
        line = json.dumps(ItemAdapter(item).asdict(), default=str) + "\n"
        self.file.write(line)
        return item
```

### Write to mongodb
```python
########## settings.py
ITEM_PIPELINES = {
#    'project.pipelines.ProjectPipeline': 300,
   'project.pipelines.MongoPipeline': 300,
}
MONGO_URI = 'mongodb://USER:PASSWORD@HOST:27017'
MONGO_DATABASE = 'data'

########## pipelines.py
import logging
import pymongo

class MongoPipeline(object):

    collection_name = 'population'
    # flat_collection_name = 'test_flat'

    def __init__(self, mongo_uri, mongo_db):
        self.mongo_uri = mongo_uri
        self.mongo_db = mongo_db

    @classmethod
    def from_crawler(cls, crawler):
        ## pull in information from settings.py
        return cls(
            mongo_uri=crawler.settings.get('MONGO_URI'),
            mongo_db=crawler.settings.get('MONGO_DATABASE')
        )

    def open_spider(self, spider):
        ## initializing spider
        ## opening db connection
        self.client = pymongo.MongoClient(self.mongo_uri)
        self.db = self.client[self.mongo_db]
        if hasattr(spider, 'collection_name'):
            self.collection_name = spider.collection_name
        # if hasattr(spider, 'flat_collection_name'):
        #     self.flat_collection_name = spider.flat_collection_name

    def close_spider(self, spider):
        ## clean up when spider is closed
        self.client.close()

    def process_item(self, item, spider):
        self.db[self.collection_name].update({'_id': item['_id']}, dict(item), upsert=True)

        logging.debug("Post added to MongoDB")
        return item
```

## Middleware
### Custom downloader
```python title=middleware.py
from scrapy.http import HtmlResponse

import cloudscraper

    def process_request(self, request, spider):
        # Called for each request that goes through the downloader
        # middleware.

        # Must either:
        # - return None: continue processing this request
        # - or return a Response object
        # - or return a Request object
        # - or raise IgnoreRequest: process_exception() methods of
        #   installed downloader middleware will be called
        # return None

        if spider.name=='hipflat':
            scraper = cloudscraper.create_scraper()
            r = scraper.get(request.url)
            body = r.content
            response = HtmlResponse(url=request.url, body=body)

            return response
```

## shell
### Set header for shell
```python
$ scrapy shell
>>> from scrapy import Request
>>> req = Request('yoururl.com', headers={"header1":"value1"})
>>> fetch(req)
```

### Use local html file
```
scrapy shell file:///path/to/file.html
```

### Create response object
```python
>>> from scrapy.http import HtmlResponse
>>> response = HtmlResponse(url="my HTML string", body='<div id="test">Test text</div>', encoding='utf-8')
>>> response.xpath('//div[@id="test"]/text()').extract()[0].strip()
u'Test text'
```

## Scrapinghub API
```python
from scrapinghub import ScrapinghubClient
from datetime import datetime

apikey = APIKEY
client = ScrapinghubClient(apikey)

project = client.get_project(PROJECT_ID)
#project.spiders.list()

spider = project.spiders.get(SPIDER_NAME)

job_lists = spider.jobs.list() # get list of all jobs

# newest on top

# {'close_reason': 'finished',
# 'elapsed': 1331426877,
# 'errors': 25,
# 'finished_time': 1597036134360,
# 'items': 5428,
# 'key': '467426/4/1',
# 'logs': 108,
# 'pages': 5642,
# 'pending_time': 1597027782530,
# 'running_time': 1597032648980,
# 'spider': 'SPIDER_NAME',
# 'state': 'finished',
# 'ts': 1597036120336,
# 'version': 'FSDFADAF-master'}]
for i in job_lists:
i['finished_time'] = str(datetime.fromtimestamp(i['finished_time']/1000).date())

workflow_day_job_id = job_lists[0]['key'] # job_id for latest job
job = client.get_job(workflow_day_job_id)

import json
with open('test_out.json', 'w') as f:
    for item in job.items.iter(): # return ALL items
    # print(item)
    f.write(json.dumps(item))
    f.write('\n')
    # break

```



## Misc
```python
# change response encoding
response.replace(encoding='utf-8')
```
