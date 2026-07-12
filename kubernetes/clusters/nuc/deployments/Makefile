livegrep-reindex: # legacy
	kubectl create job --from=cronjob/livegrep-indexer livegrep-indexer-manual -n services
	kubectl rollout restart deploy livegrep-backend --namespace services
