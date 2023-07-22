set -x
NS=wordpress
helm show values bitnami/wordpress 
helm install wordpress bitnami/wordpress -n $NS --create-namespace --set serviceType=NodePort --set  global.storageClass=local-path --values values.yaml 
helm install wordpress bitnami/wordpress -n $NS --create-namespace --set serviceType=NodePort --set  global.storageClass=openebs-hostpath --values values.yaml 
kubectl apply -f wordpress_ingress.yaml
watch kubectl -n $NS get all
kubectl api-resources
kubectl get ingressclasses
kubectl describe ingressclass nginx

WORDPRESS_POD_NAME=`kubectl -n $NS get pods --selector=app.kubernetes.io/name=wordpress -o jsonpath='{.items[*].metadata.name}'`
echo WORDPRESS_POD_NAME=$WORDPRESS_POD_NAME

kubectl -n $NS logs $WORDPRESS_POD_NAME

# $GIT_ROOT/westie-dev-pnpm/kube/bitnami/containers/bitnami/wordpress/6/debian-11/rootfs/opt/bitnami/scripts/libwordpress.sh
echo kubectl -n $NS exec -it wordpress-76b55f565f-rv78k -- bash
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp plugin list
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp plugin install bbpress --activate
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp plugin install simple-history --activate
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp simple-history list
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp plugin search gutenify
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp plugin list

# themes
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp theme list
kubectl -n $NS exec $WORDPRESS_POD_NAME -- wp theme search photo --per-page=6
