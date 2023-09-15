#!/usr/bin/env bash
echo "got: $0"
set +x
scriptpath=$(realpath "${BASH_SOURCE[0]}")
scriptdir=$(dirname "$scriptpath")
echo "scriptdir: $scriptdir"
DEVTRON_NS=devtroncd

helm repo add devtron https://helm.devtron.ai

helm repo list

helm install devtron devtron/devtron-operator --create-namespace --namespace $DEVTRON_NS \
    --values "$scriptdir"/values.yaml

kubectl -n $DEVTRON_NS wait --for=condition=ready pod -l app=devtron

# get admin password
kubectl -n devtroncd get secret devtron-secret -o jsonpath='{.data.ADMIN_PASSWORD}' | base64 -d

# get URL
kubectl get svc -n devtroncd devtron-service -o jsonpath='{.status.loadBalancer.ingress}'

# list namespaces created
kubectl get ns|grep devtron

set -x

