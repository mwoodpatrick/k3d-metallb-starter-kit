#  https://cert-manager.io/docs/installation/helm/

#  Add the Helm repository:
#

set -x 

helm repo add jetstack https://charts.jetstack.io

export CERT_MANAGER_NS=cert-manager

# Update your local Helm chart repository cache:

helm repo update

# Install cert-manager
# Example: disabling prometheus using a Helm parameter
# Example: changing the webhook timeout using a Helm parameter

helm install \
  cert-manager jetstack/cert-manager \
  --namespace $CERT_MANAGER_NS --create-namespace \
  --version v1.12.0 --set installCRDs=true --set prometheus.enabled=false --set webhook.timeoutSeconds=4

kubectl -n $CERT_MANAGER_NS get all

set +x 
