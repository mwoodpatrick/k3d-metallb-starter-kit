set -x
hostpath_dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
HOSTPATH_NS=hostpath-demo
kubectl create ns $HOSTPATH_NS

kubectl -n $HOSTPATH_NS apply -f $hostpath_dir/app-blue-shared-vol.yaml --wait=true
echo "waiting for blue app to deploy"
kubectl -n $HOSTPATH_NS wait --for=condition=Available deployment/blue-app
kubectl -n $HOSTPATH_NS expose deployment blue-app --type=NodePort
kubectl -n $HOSTPATH_NS port-forward svc/blue-app :80 &

kubectl -n $HOSTPATH_NS apply -f $hostpath_dir/app-green-shared-vol.yaml --wait=true
echo "waiting for green app to deploy"
kubectl -n $HOSTPATH_NS wait --for=condition=Available deployment/green-app
kubectl -n $HOSTPATH_NS expose deployment green-app --type=NodePort
kubectl -n $HOSTPATH_NS port-forward svc/green-app :80 &

kubectl -n $HOSTPATH_NS get all 
kubectl -n $HOSTPATH_NS get svc

# kubectl -n $HOSTPATH_NS exec -it green-app-5f87ff478d-fmlxw -- sh

set +x
