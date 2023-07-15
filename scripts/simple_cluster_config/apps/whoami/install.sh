# https://faun.pub/kubernetes-ingress-with-nginx-3c77e703e91a

kubectl apply -n whoami -f deployment.yaml
kubectl apply -n whoami -f service.yaml
kubectl -n whoami get all
kubectl -n port-forward service/whoami-service :80
