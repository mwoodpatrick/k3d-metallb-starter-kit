set -x
configmap_blue_dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
BLUE_CONFIGMAP_NS=configmap-blue
kubectl create ns $BLUE_CONFIGMAP_NS

kubectl -n $BLUE_CONFIGMAP_NS create configmap blue-web-cm --from-file=$configmap_blue_dir/index.html
kubectl -n $BLUE_CONFIGMAP_NS get configmap/blue-web-cm -o yaml
kubectl -n $BLUE_CONFIGMAP_NS describe cm/blue-web-cm

# [The Truth about “kubectl get all](https://feloy.medium.com/the-truth-about-kubectl-get-all-49cb533d8b8d#:~:text=Because%20I%20knew%20very%20few%20resources%20at%20that,the%20resources%2C%20but%20only%20a%20subset%20of%20them.)
kubectl -n $BLUE_CONFIGMAP_NS get all
kubectl -n $BLUE_CONFIGMAP_NS get cm

kubectl -n $BLUE_CONFIGMAP_NS apply -f $configmap_blue_dir/web-blue-with-cm.yaml
echo "waiting for deployment"
kubectl -n $BLUE_CONFIGMAP_NS wait --for=condition=Available deployment/blue-web

kubectl -n $BLUE_CONFIGMAP_NS port-forward deployment/blue-web :80 &

set +x
