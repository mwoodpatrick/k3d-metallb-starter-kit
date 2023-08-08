# [Debugging DNS Resolution](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/)
set -x
clusterdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
export DNS_NS=dnstest
kubectl create ns $DNS_NS
# kubectl -n $DNS_NS apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml --wait=true --namepsace $DNS_NS
kubectl -n $DNS_NS apply -f $clusterdir/dnsutils.yaml 
kubectl -n $DNS_NS wait --for=condition=Ready pod/dnsutils
kubectl -n $DNS_NS get pods dnsutils
kubectl -n $DNS_NS exec -i -t dnsutils -- nslookup kubernetes.default
kubectl -n $DNS_NS exec -i -t dnsutils -- nslookup geo.mirror.pkgbuild.com
kubectl -n $DNS_NS exec -i -t dnsutils -- nslookup google.com
kubectl delete ns $DNS_NS
set +x
