# create a deployment (i.e. nginx)
kubectl create deployment nginx --image=nginx

# expose the deployments using a LoadBalancer
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# wait for deployment
kubectl wait --timeout=5m deployment.apps/nginx --for=condition=Available

# obtain the ingress external ip
external_ip=$(kubectl get svc nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "external_ip: $external_ip"

# test the loadbalancer external ip
curl $external_ip
