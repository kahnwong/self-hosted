livegrep-reindex:
	kubectl create job --from=cronjob/livegrep-indexer livegrep-indexer-manual -n tools
	kubectl rollout restart deploy livegrep-backend --namespace tools
