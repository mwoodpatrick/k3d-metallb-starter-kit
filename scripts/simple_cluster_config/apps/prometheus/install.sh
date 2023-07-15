# https://prometheus.io/
# https://github.com/prometheus/prometheus
# https://devapo.io/blog/technology/how-to-set-up-prometheus-on-kubernetes-with-helm-charts/
# https://github.com/prometheus-community
set -x 

# add the Prometheus repository

export PROMETHEUS_NS=prometheus

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# install prometheus
helm install -n $PROMETHEUS_NS  --create-namespace -f prometheus.yaml prometheus prometheus-community/prometheus
helm install -n $PROMETHEUS_NS  --create-namespace -f prometheus-stack.yaml prometheus-stack prometheus-community/kube-prometheus-stack

kubectl -n $PROMETHEUS_NS get all

export PROMETHEUS_POD_NAME=$(kubectl get pods -n $PROMETHEUS_NS -l "app.kubernetes.io/name=prometheus-pushgateway"  -o jsonpath="{.items[0].metadata.name}")
echo "Prometheus pod name: $PROMETHEUS_POD_NAME"
echo "to view push metrics use: kubectl --namespace $PROMETHEUS_NS  port-forward $PROMETHEUS_POD_NAME 9091"
echo "to view prometheus metrics: kubectl --namespace $PROMETHEUS_NS port-forward $PROMETHEUS_POD_NAME 9090"

set +x 
