# create the k3d cluster
# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/
# https://github.com/k3d-io/k3d/pkgs/container/k3d-proxy

set -x

export K3D_FIX_DNS=1

clusterdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))

if [ -z ${K3D_CLUSTER_NAME+x} ]; 
then 
    export K3D_CLUSTER_NAME=westie-dev
    export CLUSTER_NAME=k3d-${K3D_CLUSTER_NAME}
    k3d --version
    k3d cluster create $K3D_CLUSTER_NAME --config $clusterdir/cluster-config.yaml --wait
    # k3d cluster create westie-dev --servers 1 --agents 3 --k3s-arg "--disable=traefik@server:0" --wait --volume /run/udev:/run/udev --volume /mnt/wsl/projects:/projects
    kubectl -n kube-system wait deployment.apps/metrics-server --for=condition=Available
    time kubectl -n kube-system wait apiservices v1beta1.metrics.k8s.io  --for=condition=Available --timeout=5m

    # set kubeconfig to access the k8s context
    # export KUBECONFIG=$(k3d kubeconfig write $K3D_CLUSTER_NAME)
    #
    #

    . $clusterdir/../../kube-proxy/install.sh
else 
    echo "$K3D_CLUSTER_NAME already defined!"
fi

echo "K3D_CLUSTER_NAME=${K3D_CLUSTER_NAME}"
echo "CLUSTER_NAME=${CLUSTER_NAME}"

set +x
