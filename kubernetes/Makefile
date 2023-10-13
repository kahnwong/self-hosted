coroot-port-forward:
	echo "http://localhost:8080"
	kubectl port-forward --context nuc --namespace coroot service/coroot 8080:8080
grafana-port-forward:
	echo "http://localhost:3000"
	kubectl port-forward --context nuc --namespace monitoring service/kube-prometheus-stack-grafana 3000:80
hubble-port-forward:
	kubectl port-forward -n kube-system svc/hubble-relay --address 127.0.0.1 4245:80
