# gcal agenda

- adapted from https://github.com/karenapp/google-calendar-python-api
- gcal api docs: https://developers.google.com/resources/api-libraries/documentation/calendar/v3/python/latest/calendar_v3.events.html
- html template adapted from https://github.com/crispgm/resume
- weather api docs: https://darksky.net/dev/docs

## features
- auto refresh every 30 minutes
- agenda list partitioned by day
- weather forefast

## instructions
1. Get google calendar api credentials: https://developers.google.com/calendar/quickstart/python?hl=ja
2. Store `credentials.json` at root directory
3. Set `.env` with following values:

```bash
export weather_api_key=
export font_wesome_kit_id=
export latitude=
export longitude=
```
4. `pip3 install -r requirements.txt`
5. Run `python3 create_html.py` (will ask you to authenticate in browser on first run only)
6. set htaccess password (first time only. use the outputu file to create a hardcopy and add during Dockerfile build instead): 
```bash
docker exec -it gcal-agenda /bin/bash
echo "${PASSWORD}" | htpasswd -c -i /etc/apache2/.htpasswd ${USER}
```
7. test run: `docker exec -i gcal-agenda python3 create_html.py`

## disable kindle screensaver
https://wiki.mobileread.com/wiki/Kindle_Touch_Hacking

```
;debugOn
~ds
```