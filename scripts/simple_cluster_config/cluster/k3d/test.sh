set -x

kubectl config get-contexts
kubectl config get-clusters
kubectl get apiservices
kubectl api-resources
kubectl get ingressclasses
# kubectl describe ingressclass traefik
kubectl cluster-info
kubectl get nodes --output wide
kubectl get ingress -A
kubectl get node          # or kubectl get no
kubectl get storageclass  # or kubectl get sc
kubectl get namespace     # or kubectl get ns
kubectl get pod -A

set +x
