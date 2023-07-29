set -x
k3d cluster delete $K3D_CLUSTER_NAME
unset K3D_CLUSTER_NAME
unset CLUSTER_NAME
# unset KUBECONFIG
k3d cluster list
set +x
