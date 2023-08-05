set -x
configmap_green_dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
GREEN_CONFIGMAP_NS=configmap-green
kubectl create ns $GREEN_CONFIGMAP_NS

kubectl -n $GREEN_CONFIGMAP_NS create configmap green-web-cm --from-file=$configmap_green_dir/index.html
kubectl -n $GREEN_CONFIGMAP_NS get configmap/green-web-cm -o yaml
kubectl -n $GREEN_CONFIGMAP_NS describe cm/green-web-cm

# [The Truth about “kubectl get all](https://feloy.medium.com/the-truth-about-kubectl-get-all-49cb533d8b8d#:~:text=Because%20I%20knew%20very%20few%20resources%20at%20that,the%20resources%2C%20but%20only%20a%20subset%20of%20them.)
kubectl -n $GREEN_CONFIGMAP_NS get all
kubectl -n $GREEN_CONFIGMAP_NS get cm

kubectl -n $GREEN_CONFIGMAP_NS apply -f $configmap_green_dir/web-green-with-cm.yaml
echo "waiting for deployment"
kubectl -n $GREEN_CONFIGMAP_NS wait --for=condition=Available deployment/green-web

kubectl -n $GREEN_CONFIGMAP_NS port-forward deployment/green-web :80 &

set +x
