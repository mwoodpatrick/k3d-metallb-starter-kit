# https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
# https://www.linuxtechi.com/how-to-install-kubernetes-dashboard/
set -x

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo list
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-nginx-controller 8443:443
# open https://localhost:8443
kubectl create -f k8s-dashboard-account.yaml
kubectl -n kube-system create token admin-user

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

set +x
