set -x

MARIADB_INSTALL_DIR=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
export MARIADB_NS=mariadb
helm install bitnami/mariadb --namespace $MARIADB_NS --create-namespace --generate-name
MARIADB_POD_NAME=`kubectl -n mariadb get pod -l app.kubernetes.io/name=mariadb -o jsonpath='{.items[*].metadata.name}'`
MARIADB_SVC_NAME=`kubectl -n mariadb get svc -l app.kubernetes.io/name=mariadb -o jsonpath='{.items[*].metadata.name}'`
kubectl -n $MARIADB_NS wait --for=condition=Ready pod/$MARIADB_POD_NAME

MARIADB_ROOT_PASSWORD=$(kubectl get secret --namespace $MARIADB_NS $MARIADB_SVC_NAME -o jsonpath="{.data.mariadb-root-password}" | base64 -d)
echo kubectl -n $MARIADB_NS exec -it $MARIADB_POD_NAME -- bash

echo kubectl -n mariadb exec -it $MARIADB_POD_NAME -- mysql -u root -p

echo MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD

echo MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD > $MARIADB_INSTALL_DIR/root_password

set +x
