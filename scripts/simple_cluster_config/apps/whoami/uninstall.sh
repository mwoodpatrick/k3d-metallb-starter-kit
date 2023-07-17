# https://faun.pub/kubernetes-ingress-with-nginx-3c77e703e91a

set -x

kubectl delete -f whoami.yaml -n $APP_WHOAMI_NS
kubectl delete namespace $APP_WHOAMI_NS

set +x
