mkdir -p logs
. cluster/k3d/install.sh 2>&1 | tee logs/install_cluster_k3d.log
. load_balancer/metallb/install.sh 2>&1 | tee logs/install_load_balancer_metallb.log
. apps/dashboard/install.sh 2>&1 | tee logs/install_apps_dashboard.log
. ingress/nginx/install.sh 2>&1 | tee logs/install_ingress_nginx.log
. service/load_balancer/minikube/install.sh 2>&1 | tee logs/install_load_balancer_minikube.log
