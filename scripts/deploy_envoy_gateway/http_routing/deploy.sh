# https://gateway.envoyproxy.io/v0.4.0/user/http-routing.html
set -x
# Install Envoy Gateway:

helm install eg oci://docker.io/envoyproxy/gateway-helm --version v0.4.0 -n envoy-gateway-system --create-namespace

# Wait for Envoy Gateway to become available:

kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available

# view deployed resources
helm get all eg -n envoy-gateway-system

# Install the HTTP routing example resources:

kubectl apply -f https://raw.githubusercontent.com/envoyproxy/gateway/v0.4.0/examples/kubernetes/http-routing.yaml

# Check the status of the GatewayClass:

kubectl get gc --selector=example=http-routing

# Check the status of the Gateway:

kubectl get gateways --selector=example=http-routing

# get gateway info

kubectl describe gateways/example-gateway

# Delete the GatewayClass, Gateway, HTTPRoute and Example App

kubectl delete -f https://raw.githubusercontent.com/envoyproxy/gateway/v0.4.0/examples/kubernetes/http-routing.yaml --ignore-not-found=true

# Delete the Gateway API CRDs and Envoy Gateway:

helm uninstall eg -n envoy-gateway-system

