set -x
k3d cluster delete $CLUSTER_NAME
unset CLUSTER_NAME
unset KUBECONFIG
set +x
