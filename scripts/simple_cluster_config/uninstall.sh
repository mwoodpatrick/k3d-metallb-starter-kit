. service/load_balancer/minikube/uninstall.sh 2>&1 | tee logs/uninstall_load_balancer_minikube.log
. ingress/nginx/uninstall.sh 2>&1 | tee logs/uninstall_ingress_nginx.log
. apps/dashboard/uninstall.sh 2>&1 | tee logs/uninstall_apps_dashboard.log
. load_balancer/metallb/uninstall.sh 2>&1 | tee logs/uninstall_load_balancer_metallb.log
. cluster/k3d/uninstall.sh 2>&1 | tee logs/uninstall_cluster_k3d.log
