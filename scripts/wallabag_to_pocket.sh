#!/bin/bash

### wallabag: get access_token
wallabag_access_token=$(http POST https://wallabag.karnwong.me/oauth/v2/token \
    grant_type=password \
    client_id=$wallabag_client_id \
    client_secret=$wallabag_client_secret \
    username=$wallabag_username \
password=$wallabag_password| jq -r ".access_token")

### fetch unread wallabag articles
# unread & reading_time < 6m
r=$(http GET "https://wallabag.karnwong.me/api/entries.json?perPage=50&tags=short%20read&archive=0&starred=0" \
"Authorization:Bearer $wallabag_access_token")
urls=$(echo $r | jq -r "._embedded.items[] | select((.reading_time < 4)) | .url")
entry_ids=$(echo $r | jq -r "._embedded.items[] | select((.reading_time < 4)) | .id")
echo $urls


### pocket: get code
pocket_code=$(http POST https://getpocket.com/v3/oauth/request \
    consumer_key=$pocket_consumer_key \
redirect_uri=$pocket_app_name | cut -d "=" -f 2)

### pocket: get access_token
auth_url=https://getpocket.com/auth/authorize
echo "Authorize URL: $auth_url?request_token=$pocket_code&redirect_uri=https://duckduckgo.com"

echo -n "Authorized pocket (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    ### pocket: get token
    pocket_access_token=$(http POST https://getpocket.com/v3/oauth/authorize \
        consumer_key=$pocket_consumer_key \
    code=$pocket_code | cut -d "=" -f 2 | cut -d "&" -f 1)

    ### add url to pocket
    for i in $urls
    do
        echo "Adding $i to Pocket"

        http POST https://getpocket.com/v3/add \
        consumer_key=$pocket_consumer_key \
        access_token=$pocket_access_token \
        time=$(date +%s) \
        url=$i
    done
else
    echo "Run the script again"
fi


################################################################
### wallabag: delete articles
for i in $entry_ids
do
    echo "Removing $i from Wallabag"

    http DELETE https://wallabag.karnwong.me/api/entries/$i.json \
    "Authorization:Bearer $wallabag_access_token"
done
