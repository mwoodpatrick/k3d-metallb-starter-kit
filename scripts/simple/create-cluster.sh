# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/
set -x
k3d --version
k3d cluster create containers-fan-cluster --wait
kubectl -n kube-system wait deployment.apps/metrics-server --for=condition=Available
time kubectl -n kube-system wait apiservices v1beta1.metrics.k8s.io  --for=condition=Available --timeout=5m
kubectl get apiservices
kubectl cluster-info
kubectl config get-contexts
kubectl get nodes --output wide
