# [Use an HTTP Proxy to Access the Kubernetes API] (https://kubernetes.io/docs/tasks/extend-kubernetes/http-proxy-access-api/)
# set -x
if [ -z ${KUBE_PROXY_PID+x} ]; 
then 
    KUBE_PROXY_PORT=${1:-8001}
    kubectl proxy --port=$KUBE_PROXY_PORT &
    KUBE_PROXY_PID=$!
else 
    echo "kube proxy is already running!"; 
fi
echo KUBE_PROXY_PORT=$KUBE_PROXY_PORT
echo KUBE_PROXY_PID=$KUBE_PROXY_PID
# set +x
