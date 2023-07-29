kubectl create deployment hello-minikube1 --image=kicbase/echo-server:1.0
kubectl expose deployment hello-minikube1 --type=LoadBalancer --port=8080

kubectl get deployment/hello-minikube1 -o json
kubectl get service/hello-minikube1 -o json

echo curl http://172.18.0.2:8080
echo firefox&
