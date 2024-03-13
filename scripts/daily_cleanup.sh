#!/bin/bash

# ------- wallabag -------
kubectl config use-context snikt

WALLABAG_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=wallabag | tail -1 | awk '{print $1}')"
echo $WALLABAG_POD_NAME

WALLABAG_STATEFULSET_POD_NAME="$(kubectl get pods -l=app.kubernetes.io/name=wallabag-statefulset | tail -1 | awk '{print $1}')"
echo $WALLABAG_STATEFULSET_POD_NAME

kubectl exec $WALLABAG_POD_NAME -c wallabag -- php /var/www/wallabag/bin/console wallabag:clean-duplicates --env=prod
kubectl exec $WALLABAG_POD_NAME -c wallabag -- php /var/www/wallabag/bin/console wallabag:clean-downloaded-images --env=prod
kubectl exec $WALLABAG_STATEFULSET_POD_NAME -c postgres -- psql -U wallabag -d wallabag -c "DELETE FROM wallabag_entry WHERE is_archived = 't' AND is_starred = 'f';"
