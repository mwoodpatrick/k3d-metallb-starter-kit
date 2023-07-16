# Create a nginx deployment 
# https://k3d.io/v5.0.1/usage/exposing_services Ingress
# http://vault13.co.uk/local-kubernetes-with-k3d-and-nginx-ingress/

set -x

until kubectl apply -f nginx.yaml
do
  sleep 10
done

# wait on ingress to be ready
# kubectl wait --for=condition=ready svc -l app=nginx

ip=""
while [ -z $ip ]; do
  echo "Waiting for external IP"
  ip=$(kubectl get ingress/nginx-ingress --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$ip" ] && sleep 10
done
echo 'Found external IP: '$ip

docker ps
kubectl get nodes
kubectl get svc
kubectl get ingress/nginx

# Use curl to access the nginx web app

until curl --fail localhost/
do
  sleep 10
done

set +x
