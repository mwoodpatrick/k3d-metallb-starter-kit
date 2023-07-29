# create the k3d cluster
# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/
# https://github.com/k3d-io/k3d/pkgs/container/k3d-proxy

set -x

# determine loadbalancer ingress range
# remove metallb 
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.13.5/config/manifests/metallb-native.yaml

kubectl delete namespace metallb-system

unset cidr_block
unset cidr_base_addr
unset ingress_first_addr
unset ingress_last_addr
unset ingress_range

set +x

