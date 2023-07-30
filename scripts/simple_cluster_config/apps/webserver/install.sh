set -x

webdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))

# kubectl create deployment webserver --image=nginx:alpine --replicas=3 --port=80
kubectl create -f $webdir/webserver.yaml

# create service
#  kubectl expose deployment webserver --name=web-service --type=NodePort
kubectl create -f $webdir/webserver-svc.yaml

kubectl get services

kubectl describe service web-service

set +x
