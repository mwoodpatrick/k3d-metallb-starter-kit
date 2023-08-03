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
# kubectl get ingressclasses
# kubectl describe ingressclass nginx
. service/load_balancer/minikube/install.sh 2>&1 | tee logs/install_load_balancer_minikube.log
. storage/openebs/install.sh 2>&1 | tee logs/install_openebs.log
# k get sc
. apps/wordpress/install.sh 2>&1 | tee logs/install_wordpress.log
# access http://wp.westie.dev.to see values.yaml for username & paasword
# cat apps/wordpress/values.yaml
. distros/archlinux/install.sh 2>&1 | tee logs/install_archlinux.log
# watch kubectl -n archlinux get all
# kubectl api-resources

