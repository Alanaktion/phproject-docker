K8S_NAMESPACE=phproject

start:
	@touch local-values.yaml
	@helm upgrade --dependency-update --install phproject ./ -f local-values.yaml \
		-n ${K8S_NAMESPACE} --create-namespace

stop:
	@helm uninstall -n ${K8S_NAMESPACE} phproject || true
