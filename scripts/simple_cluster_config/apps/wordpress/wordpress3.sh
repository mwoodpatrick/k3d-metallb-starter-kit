set -x
wpdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
APP=wordpress3
DOMAIN=wp3.westie.dev.to

#   --set service.type=ClusterIP \
#  --set ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
#   --set global.storageClass=openebs-hostpath \
#   --set ingress.enabled=true \
#   --set ingress.ingressClassName=nginx \
#   --set ingress.certManager=true \
#   --set serviceType=ClusterIP \
#   --set ingress.annotations."cert-manager\.io/cluster-issuer"=selfsigned-issuer \
#   --set ingress.extraTls[0].secretName=wordpress.local-tls

echo "installing $APP ..."
helm install $APP bitnami/wordpress -n $APP --create-namespace \
    --values $wpdir/wp3_values.yaml \
    --set ingress.hostname=$DOMAIN \
    --set ingress.extraTls[0].hosts[0]=$DOMAIN

kubectl -n $APP wait --timeout=10m --for=condition=ready pod -l app.kubernetes.io/instance=$APP
kubectl -n $APP wait --timeout=10m --for=condition=ready pod -l app.kubernetes.io/name=mariadb
echo "wordpress installed access at http://${DOMAIN}/"

WORDPRESS_POD_NAME=`kubectl -n $APP get pods --selector=app.kubernetes.io/name=wordpress -o jsonpath='{.items[*].metadata.name}'`
echo WORDPRESS_POD_NAME=$WORDPRESS_POD_NAME

kubectl -n $APP logs $WORDPRESS_POD_NAME

kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin list
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install wordpress-beta-tester --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install bbpress --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install simple-history --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp simple-history list
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin search gutenify
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install gutenify --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install sql-buddy --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install fakerpress --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install wp-job-manager --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin install create-block-theme --activate
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp plugin list


# themes
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp theme list
kubectl -n $APP exec $WORDPRESS_POD_NAME -- wp theme search photo --per-page=6

helm -n $APP list
helm -n $APP get values $APP | tee ${APP}_values.yaml
kubectl -n $APP get all
kubectl -n $APP get ingress
kubectl -n $APP get ingress -o json
kubectl -n $APP describe ingress $APP
kubectl -n $APP get secret
kubectl -n $APP describe secret wordpress.local-tls

set +x
