set -x
NS=default
helm show values bitnami/wordpress 
helm install wordpress bitnami/wordpress -n $NS --create-namespace --set serviceType=NodePort --set  global.storageClass=local-path --values values.yaml 
kubectl api-resources
kubectl get ingressclasses
kubectl describe ingressclass nginx
kubectl -n $NS
