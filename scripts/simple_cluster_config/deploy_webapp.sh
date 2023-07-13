# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/
set -x
kubectl apply -f deploy_webapp.yaml
kubectl get deployments --output wide
kubectl get pods --output wide
kubectl get ingress --output wide
kubectl get services --output wide
curl http://hostname.127.0.0.1.nip.io:8080
curl http://hostname.127.0.0.1.nip.io:8080
curl http://hostname.127.0.0.1.nip.io:8080

