# https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
# https://www.linuxtechi.com/how-to-install-kubernetes-dashboard/
set -x

# helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# helm repo list
# helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
# kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-nginx-controller 8443:443
# open https://localhost:8443
# kubectl create -f k8s-dashboard-account.yaml
# kubectl -n kube-system create token admin-user

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml


export VERSION_KUBE_DASHBOARD=v2.7.0
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml

kubectl create -f dashboard.admin-user.yaml -f dashboard.admin-user-role.yaml
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token

echo http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

set +x
