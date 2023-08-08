set -x
export MARIADB_NS=mariadb
helm install bitnami/mariadb --namespace $MARIADB_NS --create-namespace --generate-name
MARIADB_POD_NAME=`kubectl -n mariadb get pod -l app.kubernetes.io/name=mariadb -o jsonpath='{.items[*].metadata.name}'`
kubectl -n $MARIADB_NS wait --for=condition=Ready pod/$MARIADB_POD_NAME
echo root password=$(kubectl get secret --namespace $MARIADB_NS $MARIADB_POD_NAME -o jsonpath="{.data.mariadb-root-password}" | base64 -d)
echo kubectl -n $MARIADB_NS exec -it $MARIADB_POD_NAME -- bash

set +x
