set -x
kubectl -n $APP_NGINX_NS delete deployment.apps/nginx-deployment
kubectl -n $APP_NGINX_NS delete service/nginx-service
kubectl delete namespace $APP_NGINX_NS
set +x
