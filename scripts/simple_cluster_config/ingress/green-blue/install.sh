set -x
ingress_green_blue_dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
GREEN_BLUE_INGRESS_NS=ingress-green-blue
kubectl create ns $GREEN_BLUE_INGRESS_NS

# deplouy green web app

kubectl -n $GREEN_BLUE_INGRESS_NS create configmap green-web-cm --from-file=$ingress_green_blue_dir/../../configmaps/green/index.html

kubectl -n $GREEN_BLUE_INGRESS_NS apply -f $ingress_green_blue_dir/../../configmaps/green/web-green-with-cm.yaml
echo "waiting for green deployment"
kubectl -n $GREEN_BLUE_INGRESS_NS wait --for=condition=Available deployment/green-web

kubectl -n $GREEN_BLUE_INGRESS_NS expose deployment/green-web

kubectl  -n $GREEN_BLUE_INGRESS_NS port-forward deployment/green-web :80 &

# deplouy blue web app

kubectl -n $GREEN_BLUE_INGRESS_NS create configmap blue-web-cm --from-file=$ingress_green_blue_dir/../../configmaps/blue/index.html

kubectl -n $GREEN_BLUE_INGRESS_NS apply -f $ingress_green_blue_dir/../../configmaps/blue/web-blue-with-cm.yaml
echo "waiting for blue deployment"
kubectl -n $GREEN_BLUE_INGRESS_NS wait --for=condition=Available deployment/blue-web

kubectl -n $GREEN_BLUE_INGRESS_NS expose deployment/blue-web

kubectl  -n $GREEN_BLUE_INGRESS_NS port-forward deployment/blue-web :80 &

# apply ingress

kubectl -n $GREEN_BLUE_INGRESS_NS apply -f $ingress_green_blue_dir/virtual-host-ingress.yaml

kubectl -n $GREEN_BLUE_INGRESS_NS describe ing/fan-out-ingress
set +x
