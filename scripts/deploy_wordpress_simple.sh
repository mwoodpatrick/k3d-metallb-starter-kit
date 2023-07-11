WS_NS=ws-simple
kubectl create namespace $WS_NS
kubectl -n $WS_NS apply -k wordpress/simple
kubectl -n $WS_NS wait --timeout=5m deployment.apps/wordpress-mysql --for=condition=Available
kubectl -n $WS_NS wait --timeout=5m deployment.apps/wordpress --for=condition=Available
kubectl -n $WS_NS port-forward service/wordpress :80
