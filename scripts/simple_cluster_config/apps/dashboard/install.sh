set -x
dashboard_dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
# https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
export VERSION_KUBE_DASHBOARD=v2.7.0

echo "install dashboard ..."
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# kubectl proxy &

# open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/pod?namespace=kubernetes-dashboard and paste token

# https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
kubectl apply -f $dashboard_dir/dashboard.admin-user.yaml
kubectl apply -f $dashboard_dir/dashboard.admin-user-role.yaml
kubectl -n kubernetes-dashboard create token admin-user > $dashboard_dir/admin-user.token

echo "token in: $dashboard_dir/admin-user.token"

echo "dashboard installed"

# https://www.linuxtechi.com/how-to-install-kubernetes-dashboard/

# helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# helm repo list
# helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
# kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-nginx-controller 8443:443
# open https://localhost:8443
# kubectl create -f k8s-dashboard-account.yaml
# kubectl -n kube-system create token admin-user


# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml



# kubectl create -f dashboard.admin-user.yaml -f dashboard.admin-user-role.yaml
# kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token
# kubectl -n kubernetes-dashboard create token admin-user

echo http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

set +x
