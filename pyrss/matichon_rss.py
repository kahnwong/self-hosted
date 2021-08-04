# -*- coding: utf-8 -*-

import datetime
import PyRSS2Gen
from bs4 import BeautifulSoup
import requests
import pytz
from dateutil.parser import parse


def generate_entries(url, name):

    r = requests.get(url)
    soup = BeautifulSoup(r.content, 'html.parser')

    titles = [
        i.get('title').strip() for i in
        soup.select('div.td-main-content h3.entry-title.td-module-title > a')
    ]
    links = [
        i.get('href') for i in
        soup.select('div.td-main-content h3.entry-title.td-module-title > a')
    ]

    descriptions = titles
    guids = links

    pubdates = [
        i.get('datetime')
        for i in soup.select('div.td-main-content span.td-post-date time')
    ]

    pubdates = [parse(i) for i in pubdates]
    #     pubdates = [pytz.timezone('Asia/Bangkok').localize(i) for i in pubdates]

    entries = []
    for title, link, description, guid, pubdate in zip(
            titles, links, descriptions, guids, pubdates):
        entries.append(
            PyRSS2Gen.RSSItem(
                title=title,
                link=link,
                description=description,
                guid=PyRSS2Gen.Guid(guid),
                pubDate=pubdate), )

    # return entries

    rss = PyRSS2Gen.RSS2(
        title=name,
        link=url,
        description='Latest in {}'.format(name),
        lastBuildDate=datetime.datetime.now(),
        items=entries)

    filename = name + ".xml"
    rss.write_xml(open(filename, "w"))

    # with open(filename, 'r') as f:
    #     source_data = f.readlines()
    #
    # with open(filename, 'w') as f:
    #     new_data = source_data
    #     new_data[0] = '<?xml version="1.0" encoding="UTF-8"?>'
    #     f.writelines(new_data)


generate_entries(
    'https://www.matichonweekly.com/magazine-column/nidhi-eoseewong',
    'matichon-nidhi')
generate_entries('https://www.matichonweekly.com/magazine-column/kum-paka', 'matichon-kumpaka')
generate_entries('https://www.matichonweekly.com/magazine-column/luv-reader', 'matichon-luv-reader')
generate_entries('https://www.matichonweekly.com/magazine-column/on-history', 'matichon-on-history')

