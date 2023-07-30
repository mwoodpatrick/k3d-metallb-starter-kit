set -x

clusterdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))

if [ -z ${K3D_CLUSTER_NAME+x} ]; 
then 
    echo "Cluster unknown!"; 
else 
    . $clusterdir/../../kube-proxy/uninstall.sh
    k3d cluster delete $K3D_CLUSTER_NAME
    echo "cluster ${CLUSTER_NAME} deleted"
    unset K3D_CLUSTER_NAME
    unset CLUSTER_NAME
fi

# unset KUBECONFIG
k3d cluster list
set +x
