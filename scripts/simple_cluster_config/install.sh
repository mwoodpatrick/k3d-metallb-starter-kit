# use default kubeconfig file
# set kubeconfig to access the k8s context
# export KUBECONFIG=$(k3d kubeconfig merge $K3D_CLUSTER_NAME)

export KUBECONFIG=~/.kube/config
echo "KUBECONFIG=$KUBECONFIG"

export K3D_FIX_DNS=1

clusterdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

function kube-proxy-start {
    . $clusterdir/../../kube-proxy/install.sh
}

function k3d_create_cluster {
    export K3D_CLUSTER_NAME=${K3D_CLUSTER_NAME:-westie-dev}
    export K3D_CLUSTER_CONFIG=${K3D_CLUSTER_CONFIG:-$clusterdir/cluster/k3d/${K3D_CLUSTER_NAME}-cluster-config.yaml}
    export CLUSTER_NAME=k3d-${K3D_CLUSTER_NAME}

    echo "K3D_CLUSTER_NAME=${K3D_CLUSTER_NAME}"
    export "K3D_CLUSTER_CONFIG=$K3D_CLUSTER_CONFIG"
    echo "CLUSTER_NAME=${CLUSTER_NAME}"

    echo "before list"
    info=`k3d cluster list $K3D_CLUSTER_NAME` 2>/dev/null
    status=$?
    echo "after list"

    if (( $status == 0 )); then
        yes_or_no "cluster $K3D_CLUSTER_NAME exists, delete it" && k3d cluster delete $K3D_CLUSTER_NAME
    fi

    echo "creating cluster $K3D_CLUSTER_NAME ..."

    # k3d cluster create westie-dev --servers 1 --agents 3 --k3s-arg "--disable=traefik@server:0" --wait --volume /run/udev:/run/udev --volume /mnt/wsl/projects:/projects
    
    k3d cluster create $K3D_CLUSTER_NAME --registry-create ${K3D_CLUSTER_NAME}-registry --config $K3D_CLUSTER_CONFIG --wait

    kubectl -n kube-system wait deployment.apps/metrics-server --for=condition=Available
    time kubectl -n kube-system wait apiservices v1beta1.metrics.k8s.io  --for=condition=Available --timeout=5m

    echo "cluster $K3D_CLUSTER_NAME created"
    kubectl get nodes
    kubectl cluster-info
    # kubectl api-resources
    # kubectl get crds
}

function clear_logs {
    rm -rf logs
    mkdir -p logs
}

function load_balancer_install {
    # . apps/dns-test/test.sh
    . load_balancer/metallb/install.sh 2>&1 | tee logs/install_load_balancer_metallb.log
}

function dashboard_install {
    . apps/dashboard/install.sh 2>&1 | tee logs/install_apps_dashboard.log

    kubectl -n kubernetes-dashboard  get all
}

function nginx_ingress_install {
    . ingress/nginx/install.sh 2>&1 | tee logs/install_ingress_nginx.log

    kubectl --namespace ingress-nginx get all

    # kubectl get ingressclasses
    # kubectl describe ingressclass nginx
    # . service/load_balancer/minikube/install.sh 2>&1 | tee logs/install_load_balancer_minikube.log
}

function ebs-storage-install {
    . storage/openebs/install.sh 2>&1 | tee logs/install_openebs.log
}

function wordpress_install {
    . apps/wordpress/install.sh 2>&1 | tee logs/install_wordpress.log
    # access http://wp.westie.dev.to see values.yaml for username & paasword
    # cat apps/wordpress/values.yaml
}

function kubeapps_install {
    . apps/kubeapps/install.sh 2>&1 | tee logs/install_kubeapps.log
}

function archlinux_install {
    . distros/archlinux/install.sh 2>&1 | tee logs/install_archlinux.log
    # watch kubectl -n archlinux get all
}

function mariadb_install {
    . apps/mariadb/install.sh h 2>&1 | tee logs/install_mariadb.log
}

k3d --version
