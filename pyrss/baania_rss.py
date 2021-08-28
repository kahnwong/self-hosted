# install module from http://www.dalkescientific.com/Python/PyRSS2Gen.html
import datetime

import PyRSS2Gen
import requests
from bs4 import BeautifulSoup

# import pytz
# from dateutil.parser import parse


def generate_entries():
    url = "https://baania.com/th/baania/article/10867"

    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html.parser")

    entry_cards = soup.select("div.entity-data h3.article-title a")
    titles = [i.get_text().strip() for i in entry_cards]
    links = [i.get("href") for i in entry_cards]
    descriptions = titles
    guids = links

    pubdates = [datetime.datetime(1970, 1, 1) for i in range(len(entry_cards))]
    # pubdates = [parse(i) for i in pubdates]
    #     pubdates = [pytz.timezone('Asia/Bangkok').localize(i) for i in pubdates]

    entries = []
    for title, link, description, guid, pubdate in zip(
        titles, links, descriptions, guids, pubdates
    ):
        entries.append(
            PyRSS2Gen.RSSItem(
                title=title,
                link=link,
                description=description,
                guid=PyRSS2Gen.Guid(guid),
                pubDate=pubdate,
            ),
        )

    return entries


entries = generate_entries()
# print(entries)

rss = PyRSS2Gen.RSS2(
    title="Baania - Trends & Data",
    link="https://baania.com/th/baania/article/10867",
    description="Baania - Trends & Data",
    lastBuildDate=datetime.datetime.now(),
    items=entries,
)

rss.write_xml(open("baania.xml", "w"))

# with open('pantip.xml', 'r') as f:
#     source_data =  f.readlines()
#
# with open('pantip.xml', 'w') as f:
#     new_data = source_data
#     new_data[0] = '<?xml version="1.0" encoding="UTF-8"?>'
#     f.writelines(new_data)
