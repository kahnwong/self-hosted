from caldav.elements import dav, cdav
from datetime import datetime, timedelta
from dateutil.parser import parse
from pytz import timezone
import caldav
import json
import numpy as np
import os
import pandas as pd
import requests
import uuid

import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)


def parse_todos():
    ### read todo.txt
    todo_path = os.environ['todo_path']
    if todo_path:    
        # read from file
        with open(todo_path, 'r') as f:
            todos = [i.strip() for i in f.readlines()]

    else:
        # read from webdav
        url = os.environ['todo_url']
        webdav_username = os.environ['webdav_username']
        webdav_password = os.environ['webdav_password']
    
        todos = requests.get(url, auth=(webdav_username, webdav_password)).text
        todos = [i.strip() for i in todos.split('\n')]

    ### processing
    df = pd.DataFrame()
    df['todo'] = todos

    # extract tag
    tag_regex = r'(@[a-z]+)'
    df['tag'] = df['todo'].str.extract(tag_regex)
    df['tag'] = df['tag'].str.replace('@', '')
    df['todo'] = df['todo'].str.replace(tag_regex, '')

    # remove add date
    add_date_regex = r'(^[0-9]{4}-[0-9]{2}-[0-9]{2})'
    df['todo'] = df['todo'].str.replace(add_date_regex, '')

    # extract due date
    due_date_regex = r'due:([0-9]{4}-[0-9]{2}-[0-9]{2})'
    df['due_date'] = df['todo'].str.extract(due_date_regex)
    df['todo'] = df['todo'].str.replace(due_date_regex, '')

    # final cleanup
    df = df[df.due_date.notnull()]
    df['todo'] = df['todo'].str.strip()
    df['todo'] = np.where(df['tag'].notnull(
    ), '[' + df['tag'].str.upper() + ']' + ' ' + df['todo'], df['todo'])
    df.drop('tag', axis=1, inplace=True)

    return json.loads(df.to_json(orient='records'))


def create_vcal(todo):
    ### create params
    summary = todo['todo']

    utc = timezone('UTC')

    today = datetime.now(timezone('Asia/Bangkok')
                         ).replace(hour=0, minute=0, second=0)
    today = today.astimezone(utc)
    today = today.strftime("%Y%m%dT%H%M%SZ")

    task_start_date = todo['due_date']
    task_start_date = parse(task_start_date).date()

    task_due_date = task_start_date+timedelta(days=1)

    task_start_date = str(task_start_date).replace('-', '')
    task_due_date = str(task_due_date).replace('-', '')

    uid = uuid.uuid4()

    ######## LEAVE BODY INDENTATION AS-IS, LEADING TAB BREAKS THE ACCEPTED BODY FORMAT ########
    body = f"""BEGIN:VCALENDAR
VERSION:2.0
PRODID:FringeDivision
BEGIN:VEVENT
UID:{uid}@example.com
DTSTAMP:{today}
DTSTART;VALUE=DATE:{task_start_date}
DTEND;VALUE=DATE:{task_due_date}
SUMMARY:{summary}
END:VEVENT
END:VCALENDAR
    """

    return body


def return_calendar_object():
    ### init caldav
    client = caldav.DAVClient(
        url=os.environ['caldav_url'], username=os.environ['caldav_username'], password=os.environ['caldav_password'])
    my_principal = client.principal()

    calendar_name = os.environ['calendar_name']
    calendars = my_principal.calendars()
    calendar = [i for i in calendars if i.get_properties(
        [dav.DisplayName()])['{DAV:}displayname'] == calendar_name][0]

    # ## doesn't work with mailbox.org
    # ### delete calendar & create an empty one
    # calendar_name = os.environ['calendar_name']
    # calendars = my_principal.calendars()

    # # delete
    # calendar = [i for i in calendars if i.get_properties(
    #     [dav.DisplayName()])['{DAV:}displayname'] == calendar_name][0]
    # calendar.delete()

    # # create
    # calendar = my_principal.make_calendar(
    #     name=calendar_name, supported_calendar_component_set=['VTODO'])

    return calendar
