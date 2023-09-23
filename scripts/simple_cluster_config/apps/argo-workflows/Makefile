ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
APP:=argo
ARGO_NS:=argo

install:
	kubectl create namespace ${ARGO_NS}
	kubectl apply -n ${ARGO_NS} --wait=true -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.11/install.yaml
	kubectl -n ${ARGO_NS} wait --timeout=3m --for=condition=ready pod -l app=argo-server
	kubectl patch deployment  argo-server  --namespace ${ARGO_NS} --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [ "server", "--auth-mode=server", "--access-control-allow-origin=*" ]}]'
	# kubectl -n ${ARGO_NS} apply -f ${ROOT_DIR}/argo-ingress.yaml
	# kubectl -n ${ARGO_NS} get ing
	# curl --insecure https://argo.westie.dev.to/
	kubectl -n ${ARGO_NS} get all
	kubectl -n argo port-forward deployment/argo-server 2746:2746 &
	curl --insecure https://localhost:2746

install-cli:
	# Download the binary
	curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.5.0-rc2/argo-linux-amd64.gz

	# Unzip
	gunzip argo-linux-amd64.gz

	# Make binary executable
	chmod +x argo-linux-amd64

	# Move binary to path
	sudo mv ./argo-linux-amd64 /usr/local/bin/argo

	# Test installation
	argo version

test-app:
	argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/master/examples/hello-world.yaml

list-workflows:
	argo list -n argo

start-server:
	argo -n argo server --access-control-allow-origin=* --auth-mode=server

watch:
	watch kubectl -n ${ARGO_NS} get pods

uninstall:
	kubectl delete --wait=true ns ${ARGO_NS}

