#!/bin/bash

docker exec -t wallabag_db psql -U wallabag -d wallabag -c "DELETE FROM wallabag_entry WHERE is_archived = 't' AND is_starred = 'f';"
docker exec -t wallabag php /var/www/wallabag/bin/console wallabag:clean-downloaded-images --env=prod
