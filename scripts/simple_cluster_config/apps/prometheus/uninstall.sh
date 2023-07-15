helm -n $PROMETHEUS_NS uninstall prometheus-stack
helm -n $PROMETHEUS_NS uninstall prometheus
kubectl delete namespace $PROMETHEUS_NS
unset PROMETHEUS_NS
unset PROMETHEUS_POD_NAME
