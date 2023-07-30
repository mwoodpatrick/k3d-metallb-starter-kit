# [Use an HTTP Proxy to Access the Kubernetes API] (https://kubernetes.io/docs/tasks/extend-kubernetes/http-proxy-access-api/)
# $ to check if proxy is running use lsof -i :8001 (add -t to only get the process id's)
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
lsof -i :$KUBE_PROXY_PORT
# set +x
