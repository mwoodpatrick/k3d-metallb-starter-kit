set -x
NS=wordpress
helm show values bitnami/wordpress 
helm install wordpress bitnami/wordpress -n $NS --create-namespace --set serviceType=NodePort --set  global.storageClass=local-path --values values.yaml 
k apply -f wordpress_ingress.yaml
kubectl api-resources
kubectl get ingressclasses
kubectl describe ingressclass nginx
kubectl -n $NS get all
kubectl -n $NS exec -it wordpress-76b55f565f-rv78k -- bash
