# Create a nginx deployment 
# https://k3d.io/v5.0.1/usage/exposing_services Ingress
# http://vault13.co.uk/local-kubernetes-with-k3d-and-nginx-ingress/

set -x

export APP_NGINX_NS=nginx

kubectl create namespace $APP_NGINX_NS

until kubectl -n $APP_NGINX_NS apply -f nginx.yaml
do
  sleep 10
done

# wait on ingress to be ready
# kubectl wait --for=condition=ready svc -l app=nginx

ip=""
while [ -z $ip ]; do
  echo "Waiting for external IP"
  ip=$(kubectl -n $APP_NGINX_NS get ingress/nginx-ingress --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$ip" ] && sleep 10
done
echo 'Found external IP: '$ip

docker ps
kubectl -n $APP_NGINX_NS get nodes
kubectl -n $APP_NGINX_NS get svc
kubectl -n $APP_NGINX_NS get ingress/nginx

# Use curl to access the nginx web app

until curl --fail nginx.westie.dev.to/
do
  sleep 10
done

set +x
