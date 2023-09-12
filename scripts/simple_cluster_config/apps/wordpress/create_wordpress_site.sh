#!/usr/bin/env bash
wpdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
name=${1:-wordpress}
values=${2:-${wpdir}/my_values.yaml}
WORDPRESS_NS=${3:- wordpress-${name}}

echo "creating wordpress site $name using values $values in namespace $WORDPRESS_NS"

set -x
APP=$name
DOMAIN=${name}.westie.dev.to

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
helm install $APP bitnami/wordpress -n $WORDPRESS_NS --create-namespace \
    --values ${values} \
    --set ingress.hostname=$DOMAIN \
    --set ingress.extraTls[0].hosts[0]=$DOMAIN

kubectl -n $WORDPRESS_NS wait --timeout=10m --for=condition=ready pod -l app.kubernetes.io/instance=$APP
kubectl -n $WORDPRESS_NS wait --timeout=10m --for=condition=ready pod -l app.kubernetes.io/name=mariadb
echo "wordpress installed access at http://${DOMAIN}/"

WORDPRESS_POD_NAME=`kubectl -n $WORDPRESS_NS get pods --selector=app.kubernetes.io/name=wordpress -o jsonpath='{.items[*].metadata.name}'`
echo WORDPRESS_POD_NAME=$WORDPRESS_POD_NAME

kubectl -n $WORDPRESS_NS logs $WORDPRESS_POD_NAME

kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin list
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install wordpress-beta-tester --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install bbpress --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install simple-history --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp simple-history list
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin search gutenify
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install gutenify --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install sql-buddy --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install fakerpress --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install wp-job-manager --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install create-block-theme --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin list


# themes
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp theme list
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp theme search photo --per-page=6

helm -n $WORDPRESS_NS list
helm -n $WORDPRESS_NS get values $APP | tee ${APP}_values.yaml
echo "site $APP values in ${APP}_values.yaml"
kubectl -n $WORDPRESS_NS get all
kubectl -n $WORDPRESS_NS get ingress
kubectl -n $WORDPRESS_NS get ingress -o json
kubectl -n $WORDPRESS_NS describe ingress $APP
kubectl -n $WORDPRESS_NS get secret
kubectl -n $WORDPRESS_NS describe secret wordpress.local-tls

set +x

