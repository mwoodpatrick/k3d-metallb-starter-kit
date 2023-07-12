# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/
set -x
k3d --version
k3d cluster create containers-fan-cluster --wait
kubectl -n kube-system wait deployment.apps/metrics-server --for=condition=Ready
kubectl cluster-info
kubectl config get-contexts
kubectl get nodes --output wide
k3d cluster delete containers-fan-cluster
kubectl config get-contexts
