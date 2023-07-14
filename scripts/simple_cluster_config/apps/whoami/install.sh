# https://faun.pub/kubernetes-ingress-with-nginx-3c77e703e91a

kubectl create namespace whoami 
kubectl apply -f whoami.yaml
kubectl get all
# kubectl -n whoami port-forward service/whoami-service :80 &
