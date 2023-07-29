kubectl get svc hello-minikube1

kubectl get deployment/hello-minikube1 -o json
kubectl get service/hello-minikube1 -o json

echo curl http://172.18.0.2:8080
echo firefox&
