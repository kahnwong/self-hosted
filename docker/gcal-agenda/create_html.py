import os

from dotenv import load_dotenv
from functions import add_event_prefix
from functions import formatting
from functions import get_events
from utils.html_blocks import event
from utils.html_blocks import header
from utils.html_blocks import header_extend
from utils.html_blocks import header_today
from utils.html_blocks import section_day

load_dotenv()


def generate_html(events):
    with open("index.html", "w") as f:
        f.write(header(os.environ["font_wesome_kit_id"]))
        f.write("\n")
        f.write(header_extend())
        f.write("\n")
        f.write(header_today())
        f.write("\n")

        f.write("""<div id="contact">""")
        f.write("\n")
        # ### comment out this block if you don't want to add weather
        # weathers = get_wather()
        # for i in weathers:
        #     f.write(weather(i))
        #     f.write('\n')

        # f.write("""</div>""")
        # f.write('\n')
        # ###

        f.write("""</header>""")
        f.write("\n")

        for date in events:
            print("processing {}".format(date))

            f.write(section_day(date.strftime("%A")))
            f.write("\n")

            f.write("""<div class="section-content">""")
            f.write("\n")

            day_events = events[date]
            for i in day_events:
                f.write(event(i["start"], i["end"], i["summary"], i["next_event_in"]))
                f.write("\n")

            f.write("""</div></section>""")
            f.write("\n")

        f.write("""</body>""")


def main():
    ################
    # events
    ################
    events = get_events("primary")

    events_todo = get_events("c_qkcd4g7q4o325okcii4s1jpmg8@group.calendar.google.com")
    events_todo = add_event_prefix(events_todo, "[TODO]")

    # events_conferences = get_events(
    #     "c_9l25epokrvvi100kc4gj10oln8@group.calendar.google.com"
    # )
    # events_conferences = add_event_prefix(events_conferences, "[CONF]")

    events_j = get_events("jumpolg@baania.com")
    events_j = add_event_prefix(events_j, "[J]")

    ################
    # wrangling
    ################
    events = formatting(events, events_todo, events_j)
    generate_html(events)


main()
