# https://github.com/waybarrios/k3d-nginx-ingress
# https://ranchermanager.docs.rancher.com/getting-started/quick-start-guides/deploy-rancher-manager/helm-cli
export RANCHER_HOST=rancher.westie.dev.to

set -x

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update

kubectl create namespace cattle-system

helm install rancher rancher-latest/rancher \
	--namespace cattle-system \
    --version=2.7.5      \
    --set hostname=${RANCHER_HOST} \
     --set replicas=3  \
      --set bootstrapPassword=bacanochevere  \
      --wait           \
       --debug

helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=${RANCHER_HOST} \
  --set replicas=1 \
  --set bootstrapPassword=bacanochevere \
  --wait           \
  --debug
       
# Wait for rancher to start
kubectl -n cattle-system get deploy rancher
