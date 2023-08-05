set -x
ingress_green_blue_dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
GREEN_BLUE_INGRESS_NS=ingress-green-blue
kubectl create ns $GREEN_BLUE_INGRESS_NS

# deplouy green web app

kubectl -n $GREEN_BLUE_INGRESS_NS create configmap green-web-cm --from-file=$ingress_green_blue_dir/../../configmaps/green/index.html

kubectl -n $GREEN_BLUE_INGRESS_NS apply -f $ingress_green_blue_dir/../../configmaps/green/web-green-with-cm.yaml
echo "waiting for green deployment"
kubectl -n $GREEN_BLUE_INGRESS_NS wait --for=condition=Available deployment/green-web

# deplouy blue web app

kubectl -n $GREEN_BLUE_INGRESS_NS create configmap blue-web-cm --from-file=$ingress_green_blue_dir/../../configmaps/blue/index.html

kubectl -n $GREEN_BLUE_INGRESS_NS apply -f $ingress_green_blue_dir/../../configmaps/blue/web-blue-with-cm.yaml
echo "waiting for blue deployment"
kubectl -n $GREEN_BLUE_INGRESS_NS wait --for=condition=Available deployment/green-web

# apply ingress

kubectl -n $GREEN_BLUE_INGRESS_NS apply -f $ingress_green_blue_dir/virtual-host-ingress.yaml

set +x
