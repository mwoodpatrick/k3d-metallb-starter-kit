set -x

helm --namespace $CERT_MANAGER_NS delete cert-manager

kubectl delete namespace $CERT_MANAGER_NS

unset CERT_MANAGER_NS

set +x
