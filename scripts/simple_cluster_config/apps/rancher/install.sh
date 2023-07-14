# https://github.com/waybarrios/k3d-nginx-ingress
# https://ranchermanager.docs.rancher.com/getting-started/quick-start-guides/deploy-rancher-manager/helm-cli
# https://medium.com/47billion/playing-with-kubernetes-using-k3d-and-rancher-78126d341d23
export RANCHER_HOST=rancher.westie.dev.to

set -x

kubectl delete namespace cattle-system

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update

helm install rancher rancher-latest/rancher \
   --namespace cattle-system \
   --create-namespace \
   --set ingress.enabled=false \
   --set tls=external \
   --set replicas=1

kubectl apply -f rancher.yaml
