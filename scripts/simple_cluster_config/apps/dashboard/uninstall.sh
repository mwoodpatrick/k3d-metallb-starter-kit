kubectl delete --ignore-not-found=true -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
kubectl delete --ignore-not-found=true ns/kubernetes-dashboard
# kubectl delete ns kubernetes-dashboard
# kubectl delete clusterrolebinding kubernetes-dashboard
# kubectl delete clusterrole kubernetes-dashboard


