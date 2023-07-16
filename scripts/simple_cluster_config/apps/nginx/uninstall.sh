set -x
k delete deployment.apps/nginx-deployment
k delete service/nginx-service
set +x
