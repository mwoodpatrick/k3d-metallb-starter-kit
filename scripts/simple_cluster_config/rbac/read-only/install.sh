# https://www.golinuxcloud.com/kubernetes-service-account/
# Lab K401 - Creating Users, Groups and Authorization - Kubernetes Tutorial with CKA/CKAD Prep (schoolofdevops.com)
# https://kubernetes-tutorial.schoolofdevops.com/configuring_authentication_and_authorization/
set -x
nvim read-only-service-account.yaml
nvim read-only-service-account-cluster-role.yaml
nvim read-only-service-account-cluster-role-binding.yml
k apply -f  read-only-service-account.yaml -f read-only-service-account-cluster-role.yaml -f read-only-service-account-cluster-role-binding.yml
	serviceaccount/read-only-user created
	clusterrole.rbac.authorization.k8s.io/read-only-user-cluster-role created
	clusterrolebinding.rbac.authorization.k8s.io/read-only-user-cluster-role-binding created
k get pods --all-namespaces
k describe pod -n cattle-system rancher-f774856cc-p7rlr

kubectl --as=system:serviceaccount:default:read-only-user get pods --all-namespaces

kubectl --as=system:serviceaccount:default:read-only-user describe pod -n cattle-system rancher-f774856cc-p7rlr
	Error from server (Forbidden): pods "rancher-f774856cc-p7rlr" is forbidden: User "system:serviceaccount:default:read-only-user" cannot get resource "pods" in API group "" in the namespace "cattle-system"

set +x
