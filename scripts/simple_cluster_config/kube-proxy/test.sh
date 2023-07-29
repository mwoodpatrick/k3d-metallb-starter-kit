set -x
curl http://localhost:$KUBE_PROXY_PORT
echo
curl http://localhost:$KUBE_PROXY_PORT/api/v1/namespaces/default/pods
echo
set +x
