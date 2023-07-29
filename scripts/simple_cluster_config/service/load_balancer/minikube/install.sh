_d=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
kubectl create deployment hello-minikube1 --image=kicbase/echo-server:1.0
kubectl expose deployment hello-minikube1 --type=LoadBalancer --port=8080
. $_d/test.sh
unset _d

