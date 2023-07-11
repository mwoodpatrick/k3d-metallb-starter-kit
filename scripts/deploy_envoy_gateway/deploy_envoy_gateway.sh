# https://gateway.envoyproxy.io/v0.4.0/user/quickstart.html
# Install the Gateway API CRDs and Envoy Gateway
helm install eg oci://docker.io/envoyproxy/gateway-helm --version v0.4.0 -n envoy-gateway-system --create-namespace

# Wait for Envoy Gateway to become available
kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available

# Install the GatewayClass, Gateway, HTTPRoute and example app
kubectl apply -f https://github.com/envoyproxy/gateway/releases/download/v0.4.0/quickstart.yaml -n default

# Get the name of the Envoy service created the by the example Gateway
export ENVOY_SERVICE=$(kubectl get svc -n envoy-gateway-system --selector=gateway.envoyproxy.io/owning-gateway-namespace=default,gateway.envoyproxy.io/owning-gateway-name=eg -o jsonpath='{.items[0].metadata.name}')

# Port forward to the Envoy service
kubectl -n envoy-gateway-system port-forward service/${ENVOY_SERVICE} 8888:80 &

# Curl the example app through Envoy proxy
curl --verbose --header "Host: www.example.com" http://localhost:8888/get

echo "GATEWAY_HOST not defined, need to debug"
# test the same functionality by sending traffic to the External IP. To get the external IP of the Envoy service, run
# export GATEWAY_HOST=$(kubectl get svc/${ENVOY_SERVICE} -n envoy-gateway-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Curl the example app through Envoy proxy
# curl --verbose --header "Host: www.example.com" http://$GATEWAY_HOST/get
#
# Uninstall everything from the quickstart guide.
# Delete the GatewayClass, Gateway, HTTPRoute and Example App

kubectl delete -f https://github.com/envoyproxy/gateway/releases/download/v0.4.0/quickstart.yaml --ignore-not-found=true

# Delete the Gateway API CRDs and Envoy Gateway

helm uninstall eg -n envoy-gateway-system
