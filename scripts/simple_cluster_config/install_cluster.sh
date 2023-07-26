# create the k3d cluster
# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/
# https://github.com/k3d-io/k3d/pkgs/container/k3d-proxy

set -x

k3d --version
k3d cluster create $CLUSTER_NAME --config cluster-config.yaml --wait
export CLUSTER_NAME=k3d-westie-dev
# k3d cluster create westie-dev --servers 1 --agents 3 --k3s-arg "--disable=traefik@server:0" --wait --volume /run/udev:/run/udev --volume /mnt/wsl/projects:/projects
kubectl config get-contexts
kubectl -n kube-system wait deployment.apps/metrics-server --for=condition=Available
time kubectl -n kube-system wait apiservices v1beta1.metrics.k8s.io  --for=condition=Available --timeout=5m
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

# set kubeconfig to access the k8s context
export KUBECONFIG=$(k3d kubeconfig write $CLUSTER_NAME)

# validate the cluster master and worker nodes

kubectl get nodes
kubectl config get-contexts

set +x
