set -x
NS=wordpress
helm show values bitnami/wordpress 
helm install wordpress bitnami/wordpress -n $NS --create-namespace --set serviceType=NodePor --set  global.storageClass=local-path --values values.yaml 
kubectl api-resources
kubectl get ingressclasses
k describe ingressclass traefik
kubectl -n $NS
