---
title: Built-in modules
---

## JSON
### Read / write
```python
with open('online_listing.json', 'w') as f:
    json.dump(l, f, indent=4, ensure_ascii=False)
```

### Mass re-encode file
```python
def change_encoding(encoding_from='cp874', encoding_to='utf-8', files=files):
    print('===== Start conversion from {} to {} ====='.format(encoding_from, encoding_to))
    for i in files:
        print(i)

        with open(i, 'r', encoding=encoding_from, errors='ignore') as f: # open Thai file
            data = f.read()
            data = data.encode(encoding_to, 'ignore') # convert to UTF-8

        # print(data)

        with open(i, 'wb') as f: # SAVE
            f.write(data)
```

### Serialize json
:::info
prevents datetime serialize error
:::

```python
from bson import json_util
import json

json.dumps(anObject, default=json_util.default)
```

```python
def myconverter(o):
    if isinstance(o, datetime.datetime):
        return o.__str__()

json.dumps(anObject, default=myconverter)
```

```python
str_output = ''
for i in cursor:
    str_output += f'{json.dumps(i, default=str)}\n'
```

```python
json.dumps(my_dictionary, indent=4, sort_keys=True, default=str)
```

#### Deserialize
```python
json.loads(aJsonString, object_hook=json_util.object_hook)
```

## List
```python
### split on nth occurrence 
>>> "a b c,d,e,f".rsplit(',',1)
['a b c,d,e', 'f']

### Split list every n chunk
[data[x:x+100] for x in range(0, len(data), 100)]

### pick random element from list
import random

foo = ['a', 'b', 'c', 'd', 'e']
print(random.choice(foo))
```

## String
### Check substrings from list
```python
>>> thai_sites = ['silpa-mag.com', 'matichonweekly.com', 'thematter.co', 'prachatai',]
>>> string = 'https://prachataisomething'
>>> any(substring in string for substring in substring_list)
True
```

### Replace n occurrence
```python
text.replace("very", "not very", 1)
```

### Remove \t \n
```python
' '.join(myString.split())
```

### Substring, superstring
```python
>>> SUB = str.maketrans("0123456789", "₀₁₂₃₄₅₆₇₈₉")
>>> SUP = str.maketrans("0123456789", "⁰¹²³⁴⁵⁶⁷⁸⁹")
>>> "H2SO4".translate(SUB)
'H₂SO₄'

>>>print("The area of your rectangle is {}cm\u00b2".format(33))
The area of your rectangle is 33cm²
```

## SMTP
```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from datetime import datetime

fromaddr = 'example@example.com'
toaddr = 'john@doe.com'

msg = MIMEMultipart()

msg['From'] = fromaddr
msg['To'] = toaddr
msg['Subject'] = "Hello there"

body = "For {}".format(str(datetime.now().date()))

msg.attach(MIMEText(body, 'plain'))

filename = "presents_list"
attachment = open(filename, "rb")

part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header('Content-Disposition', "attachment; filename= %s" % filename)

msg.attach(part)

server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login(fromaddr, PASSWORD)
text = msg.as_string()
server.sendmail(fromaddr, toaddr, text)
server.quit()˜e
```

## CSV
### Read CSV as dict
```python
with open('params.csv', 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    data = [dict(i) for i in reader]
```

## Regex
### Usage
```python
import re

regex = r'[0-9,\.]+'
numbers = re.search(regex, str).group(0).replace(',', '')
```

### Find text between two strings
```python
import re
pattern = re.compile(
    r'\STRING_A(.+?)\STRING_B', flags=re.DOTALL)
text = """ตามหลักเกณฑ์ การกำหนดมูลค่าตลาด\n\t\t\tด้วยวิธีเปรียบเทียบราคาตลาด ( Market\n\t\t\tApproach)'"""

results = pattern.findall(text)
# ['there my fine\nfellow!', 'such a glorious day?']
print(results)
```

### Lookahead & lookbehind
Given the string `foobarbarfoo`

| Regex       | Description                                                   |
| ----------- | ------------------------------------------------------------- |
| bar(?=bar)  | finds the 1st bar ("bar" which has "bar" after it)            |
| bar(?!bar)  | finds the 2nd bar ("bar" which does not have "bar" after it)  |
| (?<=foo)bar | finds the 1st bar ("bar" which has "foo" before it)           |
| (?<!foo)bar | finds the 2nd bar ("bar" which does not have "foo" before it) |


## Datetime
```python
from datetime import datetime, timedelta
from dateutil.parser import parse
from dateparser import parse as parsethai
from pytz import timezone
import os


# timedelta
datetime.now() + timedelta(days=10)
datetime.now() + timedelta(hours=7)

# attach tz to datetime object
timezone('Asia/Bangkok').localize(datetime.now())

# get current datetime in specified tz
datetime.now(timezone('Asia/Bangkok'))

# to string
datetime.now().strftime('%Y-%m-%d %H:%M:%S')

# from string
datetime.strptime(datetime.now(), '%Y-%m-%d')

# replace datetime object attributes
pubdate.replace(tzinfo=None)
pubdate.replace(year=pubdate.year - 543)

# from epoch timestamp
datetime.fromtimestamp(1347517370/1000) # /1000 in case of ValueError

# set system tz env var on-the-fly
os.environ['TZ'] = 'UTC'

# convert datetime value to target tz (eg. 00:00AM to 07:00AM from UTC to Asia/Bangkok)
utc = timezone('UTC')
datetime.now().astimezone(utc)
```

## Threading
```python
from multiprocessing.dummy import Pool as ThreadPool

pool = ThreadPool(8)
results = pool.map(crunch, texts[:20])

pool.close()
pool.join()
```

```python
from multiprocessing import Pool
def f(x): # function BEFORE Pool
    return x*x

p = Pool(5)
p.map(f, [1,2,3])
```

## Time
### Find elapsed time
```python
import time

start_time = time.time()

# ... do stuff

end_time = time.time()
print("Elapsed time was %g seconds" % (end_time - start_time))
```

```python
import timeit

start = timeit.default_timer()
#Your statements here
stop = timeit.default_timer()
print('Time: ', stop - start) 
```

### Countdown function
```python
def countdown(t):
    print('--- SLEEP ---')
    while t:
        mins, secs = divmod(t, 60)
        timeformat = '{:02d}:{:02d}'.format(mins, secs)
        print(timeformat, end='\r')
        sleep(1)
        t -= 1
```

### Time decorator
```python
from horology import timed # pip install horology 


@timed # put this line above ALL functions
def compute_magic(n):
    counter = 0
    for i in range(n):
        counter+=i

    print(counter)
    return counter

compute_magic(10000000)

# output
# compute_magic: 681.55 ms
```

## Exception
### Print stacktrace
```python
except Exception as e:
    import traceback

    error_msg = ''.join(traceback.format_exception(
        etype=type(e), value=e, tb=e.__traceback__))
    print(error_msg)
```

## Dict
```python
# sort dict based on value
sorted(list_to_be_sorted, key=lambda k: k['name']) 

# find key diff
list(set(keep_keys)-set(input_keys))
```

## Sys
```python
# add prefix for system path
import sys
sys.path.insert(0, "../..")
```

## Joblib
### Create hash
```python
def gen_hash(row):
    values = list(row)
    print(list(values))
    print('====')
    
    return joblib.hash(values)
```

## Log

### Init
```python
class Logger:
    def info(self, text:str):
        print("[INFO] " + text)
        
    def warn(self, text:str):
        print("[WARN] " + text)
        
    def error(self, text:str):
        print("[ERROR] " + text)
```

### Usage
```python
>>> from log import Logger
>>> log = Logger()
>>> log.info('test')
[INFO] test
```