from datetime import datetime
import os
from utils.cal_setup import get_calendar_service
import requests
from dateutil.parser import parse
import pandas as pd
import numpy as np
import json


def get_events():
    service = get_calendar_service()
    # Call the Calendar API
    now = datetime.utcnow().isoformat() + 'Z'  # 'Z' indicates UTC time
    print('Getting List of 10 events')
    events_result = service.events().list(calendarId='primary', timeMin=now,
                                          maxResults=10, singleEvents=True,
                                          orderBy='startTime').execute()
    events = events_result.get('items', [])

    if not events:
        print('No upcoming events found.')
        return ['No events today.']

    else:
        output = []
        for event in events:
            start = event['start'].get('dateTime', event['start'].get('date'))
            end = event['end'].get('dateTime', event['start'].get('date'))
            # print(start, event['summary'])

            d = {}
            d['start'] = start
            d['end'] = end
            d['summary'] = event['summary']
            output.append(d)

        return output



def get_weather():
    url = 'https://api.darksky.net/forecast/{}/{},{}?units=auto&exclude=minutely,daily,alerts,currently,flags'\
        .format(os.environ['weather_api_key'],
                os.environ['latitude'],
                os.environ['longitude'])

    r = requests.get(url).json()

    ### processing
    weathers_raw = []
    weathers_raw.append(r['hourly']['data'][0])  # current
    weathers_raw.append(r['hourly']['data'][2])  # in two hours

    # "darksky: fontawesome"
    icon_dict = {
        'clear-day': 'sun',
        'clear-night': 'moon',
        'rain': 'cloud-rain',
        'snow': 'snowflake',
        'wind': 'wind',
        'cloudy': 'cloud',
        'partly-cloudy-day': 'cloud-sun',
        'partly-cloudy-night': 'cloud-moon',
    }

    weathers = [{
        'title': 'Overview',
        'icon': icon_dict[r['hourly']['icon']],
        'summary': r['hourly']['summary'],
        'temperature': None
    }]
    for i in weathers_raw:
        d = {}
        d['title'] = datetime.fromtimestamp(
            i['time']).strftime('%-I%p')  # time
        d['icon'] = icon_dict[i['icon']]
        d['summary'] = i['summary']
        d['temperature'] = i['apparentTemperature']

        weathers.append(d)

    return weathers


def formatting(events):
    ###
    for i in events:
        i['date'] = parse(i['start']).date()
        i['start'] = parse(i['start']).strftime('%H:%M')
        i['end'] = parse(i['end']).strftime('%H:%M')

    ###  
    events_partition = {}
    for i in events:
        date = i['date']

        # create day_name key
        if not events_partition.get(date):
            events_partition[date] = []

        events_partition[date].append(i)

    ### processing each day chunk for time until next event
    for key in events_partition:
        day_events = events_partition[key]
        df = pd.DataFrame(day_events)

        ## create dt object for start / end time
        df['start_dt'] = pd.to_datetime(df['date'].astype(str) + ' ' + df['start'])
        df['end_dt'] = pd.to_datetime(df['date'].astype(str) + ' ' + df['end'])

        ## calculate time until next event
        df['next_event_in'] = df['start_dt'].shift(-1) - df['end_dt']
        df['next_event_in'] = df['next_event_in'] / np.timedelta64(1, 'h')

        ## sanitize time until next event
        df['next_event_in'] = df['next_event_in'].replace(0, np.nan)
        df['next_event_in'] = np.where(
            df['next_event_in'].notnull(),
            df['next_event_in'].astype(str).str.replace('.0', '', regex=False),
            df['next_event_in'])

        df.drop(['start_dt', 'end_dt'], axis=1, inplace=True)

        ## convert to json
        def parse_date(d):
            if 'date' in d:
                d['date'] = datetime.fromtimestamp(d['date']/1000).date()
            return d

        d = json.loads(df.to_json(orient='records'), object_hook=parse_date)

        events_partition[key] = d

    return events_partition
