k3d cluster delete westie-dev

# check for kube proxy
lsof -i :8001
rm -rf logs
mkdir -p logs

. cluster/k3d/install.sh 2>&1 | tee logs/install_cluster_k3d.log
# . apps/dns-test/test.sh
. load_balancer/metallb/install.sh 2>&1 | tee logs/install_load_balancer_metallb.log
. apps/dashboard/install.sh 2>&1 | tee logs/install_apps_dashboard.log
. ingress/nginx/install.sh 2>&1 | tee logs/install_ingress_nginx.log
. service/load_balancer/minikube/install.sh 2>&1 | tee logs/install_load_balancer_minikube.log
. storage/openebs/install.sh 2>&1 | tee logs/install_openebs.log
. apps/wordpress/install.sh 2>&1 | tee logs/install_wordpress.log
. distros/archlinux/install.sh 2>&1 | tee logs/install_archlinux.log
