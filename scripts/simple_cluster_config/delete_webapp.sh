# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/
set -x
kubectl delete -f deploy_webapp.yaml
kubectl get deployments --output wide
kubectl get services --output wide
