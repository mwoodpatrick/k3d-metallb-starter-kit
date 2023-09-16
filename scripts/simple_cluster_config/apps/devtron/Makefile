ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
APP:=devtron
DEVTRON_NS:=devtroncd

repo_add:
	helm repo add ${APP} https://helm.devtron.ai

repo_list:
	helm repo list

install:
	helm install devtron devtron/devtron-operator --create-namespace --namespace ${DEVTRON_NS} --values ${ROOT_DIR}/values.yaml
	kubectl -n ${DEVTRON_NS} wait --timeout=3m --for=condition=ready pod -l app=devtron
	echo "run make get_password"

watch:
	watch kubectl -n ${DEVTRON_NS} get pods

upgrade:
	helm upgrade ${APP} devtron/devtron-operator --namespace ${DEVTRON_NS} --values ${ROOT_DIR}/values.yaml

uninstall:
	kubectl delete --wait=true ns ${DEVTRON_NS} devtron-cd devtron-ci argo

get_values:
	helm -n ${DEVTRON_NS} get values devtron

get_password:
	kubectl -n ${DEVTRON_NS} get secret devtron-secret -o jsonpath='{.data.ADMIN_PASSWORD}' | base64 -d # get admin password

get_url:
	kubectl -n ${DEVTRON_NS} get svc devtron-service -o jsonpath='{.status.loadBalancer.ingress}' # get URL


