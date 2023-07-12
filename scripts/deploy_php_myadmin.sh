# https://github.com/bitnami/charts/tree/main/bitnami/phpmyadmin
helm install my-release oci://registry-1.docker.io/bitnamicharts/phpmyadmin
kubectl port-forward --namespace default svc/my-release-phpmyadmin :80
kubectl describe deployment.apps/my-release-phpmyadmin
kubectl get all

