# install module from http://www.dalkescientific.com/Python/PyRSS2Gen.html
import datetime

import PyRSS2Gen
import requests
from bs4 import BeautifulSoup


def generate_entries(url, name):

    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html.parser")

    titles = [
        i.get_text().strip() for i in soup.select("div.news-item h2.news-title a")
    ]

    links = [i.get("href") for i in soup.select("div.news-item h2.news-title a")]

    descriptions = titles
    guids = links

    pubdates = [datetime.datetime(1970, 1, 1) for i in range(len(titles))]

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

    # return entries

    rss = PyRSS2Gen.RSS2(
        title=name,
        link=url,
        description="Latest in {}".format(name),
        lastBuildDate=datetime.datetime.now(),
        items=entries,
    )

    filename = name + ".xml"
    rss.write_xml(open(filename, "w"))

    # with open(filename, 'r') as f:
    #     source_data = f.readlines()
    #
    # with open(filename, 'w') as f:
    #     new_data = source_data
    #     new_data[0] = '<?xml version="1.0" encoding="UTF-8"?>'
    #     f.writelines(new_data)


generate_entries("https://thestandard.co/pop/eat-drink/", "thestandard-eat-drink")
generate_entries("https://thestandard.co/opinion/", "thestandard-opinion")
