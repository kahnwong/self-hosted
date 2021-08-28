# install module from http://www.dalkescientific.com/Python/PyRSS2Gen.html
import datetime

import PyRSS2Gen
import requests
from bs4 import BeautifulSoup
from dateutil.parser import parse


def generate_entries():
    url = "https://pantip.com/tag/%E0%B8%A0%E0%B8%B2%E0%B8%A9%E0%B8%B2%E0%B8%AD%E0%B8%B1%E0%B8%87%E0%B8%81%E0%B8%A4%E0%B8%A9"

    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html.parser")

    titles = [i.get_text().strip() for i in soup.select("div.post-item-title > a")]
    links = [
        "https://pantip.com" + i.get("href")
        for i in soup.select("div.post-item-title > a")
    ]
    descriptions = titles
    guids = links

    pubdates = [
        i.get("data-utime")
        for i in soup.select("div.post-item-by > span.timestamp  > abbr.timeago")
    ]
    pubdates = [parse(i) for i in pubdates]
    #  pubdates = [pytz.timezone('Asia/Bangkok').localize(i) for i in pubdates]

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
    title="ภาษาอังกฤษ - Pantip",
    link="https://pantip.com/tag/%E0%B8%A0%E0%B8%B2%E0%B8%A9%E0%B8%B2%E0%B8%AD%E0%B8%B1%E0%B8%87%E0%B8%81%E0%B8%A4%E0%B8%A9",
    description="Latest threads in ภาษาอังกฤษ",
    lastBuildDate=datetime.datetime.now(),
    items=entries,
)

rss.write_xml(open("pantip.xml", "w"))
