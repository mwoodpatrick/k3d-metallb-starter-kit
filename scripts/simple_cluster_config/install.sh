k3d cluster delete westie-dev

# check for kube proxy
lsof -i :8001
rm -rf logs
mkdir -p logs

echo "creating cluster"
. cluster/k3d/install.sh 2>&1 | tee logs/install_cluster_k3d.log
echo "cluster created"
kubectl get nodes
# . apps/dns-test/test.sh
. load_balancer/metallb/install.sh 2>&1 | tee logs/install_load_balancer_metallb.log


. apps/dashboard/install.sh 2>&1 | tee logs/install_apps_dashboard.log

kubectl -n kubernetes-dashboard  get all

. ingress/nginx/install.sh 2>&1 | tee logs/install_ingress_nginx.log
kubectl --namespace ingress-nginx get all

# kubectl get ingressclasses
# kubectl describe ingressclass nginx
# . service/load_balancer/minikube/install.sh 2>&1 | tee logs/install_load_balancer_minikube.log

. storage/openebs/install.sh 2>&1 | tee logs/install_openebs.log

. apps/wordpress/install.sh 2>&1 | tee logs/install_wordpress.log

. apps/kubeapps/install.sh 2>&1 | tee logs/install_kubeapps.log

# access http://wp.westie.dev.to see values.yaml for username & paasword
# cat apps/wordpress/values.yaml
. distros/archlinux/install.sh 2>&1 | tee logs/install_archlinux.log
# watch kubectl -n archlinux get all
# kubectl api-resources

. apps/mariadb/install.sh h 2>&1 | tee logs/install_mariadb.log
