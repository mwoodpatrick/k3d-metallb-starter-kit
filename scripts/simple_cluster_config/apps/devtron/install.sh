set +x
wpdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
DEVTRON_NS=devtroncd

helm repo add devtron https://helm.devtron.ai

helm repo list

# helm install devtron devtron/devtron-operator --create-namespace --namespace $DEVTRON_NS
helm install devtron devtron/devtron-operator --create-namespace --namespace $DEVTRON_NS \
    --set components.devtron.ingress.enabled=true \
    --set components.devtron.ingress.className=nginx \
    --set components.devtron.ingress.host=devtron.westie.dev.to \
    --set components.devtron.ingress.pathType=Prefix \
    --set components.devtron.ingress.tls=???? \
    --set installer.modules={cicd} \
    --set argo-cd.enabled=true

kubectl -n $DEVTRON_NS wait --for=condition=ready pod -l app=devtron

# get admin password
kubectl -n devtroncd get secret devtron-secret -o jsonpath='{.data.ADMIN_PASSWORD}' | base64 -d

# get URL
kubectl get svc -n devtroncd devtron-service -o jsonpath='{.status.loadBalancer.ingress}'

# list namespaces created
kubectl get ns|grep devtron

set -x

