#!/usr/bin/env bash
wpdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
set +x
name=${1:-wordpress}
values=${2:-${wpdir}/values.yaml}
WORDPRESS_NS=${3:-$name}
echo "name=$name values=$values WORDPRESS_NS=$WORDPRESS_NS"
kubectl create namespace $WORDPRESS_NS
helm show values bitnami/wordpress 
# helm install wordpress bitnami/wordpress -n $WORDPRESS_NS --create-namespace --set serviceType=NodePort --set  global.storageClass=local-path --values values.yaml 

echo "installing $name ..."
helm install $name bitnami/wordpress -n $WORDPRESS_NS --create-namespace --set serviceType=ClusterIP --set  global.storageClass=openebs-hostpath --values $values
exit
kubectl apply -f $wpdir/wordpress_ingress.yaml
kubectl -n wordpress wait --for=condition=ready pod -l app.kubernetes.io/instance=wordpress
kubectl -n wordpress wait --for=condition=ready pod -l app.kubernetes.io/name=mariadb
echo "wordpress installed access at http://wp.westie.dev.to/"

WORDPRESS_POD_NAME=`kubectl -n $WORDPRESS_NS get pods --selector=app.kubernetes.io/name=wordpress -o jsonpath='{.items[*].metadata.name}'`
echo WORDPRESS_POD_NAME=$WORDPRESS_POD_NAME

kubectl -n $WORDPRESS_NS logs $WORDPRESS_POD_NAME

# $GIT_ROOT/westie-dev-pnpm/kube/bitnami/containers/bitnami/wordpress/6/debian-11/rootfs/opt/bitnami/scripts/libwordpress.sh
echo kubectl -n $WORDPRESS_NS exec -it $WORDPRESS_POD_NAME -- bash
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin list
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install wordpress-beta-tester --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install bbpress --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin install simple-history --activate
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp simple-history list
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin search gutenify
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp plugin list

# themes
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp theme list
kubectl -n $WORDPRESS_NS exec $WORDPRESS_POD_NAME -- wp theme search photo --per-page=6

watch kubectl -n $WORDPRESS_NS get all
