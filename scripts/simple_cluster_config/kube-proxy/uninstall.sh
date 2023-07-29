# [Use an HTTP Proxy to Access the Kubernetes API] (https://kubernetes.io/docs/tasks/extend-kubernetes/http-proxy-access-api/)
# set -x
if [ -z ${KUBE_PROXY_PID+x} ]; 
then 
    echo "kube proxy is not running!"; 
else 
    echo "stopping kubectl proxy (KUBE_PROXY_PID=$KUBE_PROXY_PID)"; 
    kill -TERM $KUBE_PROXY_PID
fi
unset KUBE_PROXY_PORT
unset KUBE_PROXY_PID
# set +x
