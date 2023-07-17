# https://faun.pub/kubernetes-ingress-with-nginx-3c77e703e91a

set -x

export APP_WHOAMI_NS=whoami
kubectl create namespace $APP_WHOAMI_NS
kubectl apply -f whoami.yaml -n $APP_WHOAMI_NS
kubectl -n $APP_WHOAMI_NS get all
# kubectl -n whoami port-forward service/whoami-service :80 &

set +x
