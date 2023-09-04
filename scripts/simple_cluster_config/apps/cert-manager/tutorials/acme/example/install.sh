# https://cert-manager.io/docs/tutorials/acme/nginx-ingress/
set +x
acmedir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
ACME_NS=cert-manager-acme
kubectl create namespace $ACME_NS

kubectl -n $ACME_NS apply -f https://raw.githubusercontent.com/cert-manager/website/master/content/docs/tutorials/acme/example/deployment.yaml

kubectl -n $ACME_NS apply -f https://raw.githubusercontent.com/cert-manager/website/master/content/docs/tutorials/acme/example/service.yaml

kubectl  -n $ACME_NS apply -f $acmedir/whoami_deployment.yaml
kubectl  -n $ACME_NS apply -f $acmedir/whoami_service.yaml

kubectl  -n $ACME_NS get all

kubectl -n $ACME_NS apply -f $acmedir/acme-ingress-tls.yaml
# expected output: ingress.networking.k8s.io/kuard created

kubectl -n $ACME_NS apply -f $acmedir/whoami-ingress-tls.yaml
# expected output: ingress.networking.k8s.io/whoami created

kubectl -n $ACME_NS get ing

# use https to avoid 308 redirect
# https://blog.airbrake.io/blog/http-errors/308-permanent-redirect
# curl -k https://whoami.example.com/

kubectl apply -f $acmedir/staging-issuer.yaml
# expected output: issuer.cert-manager.io "letsencrypt-staging" created

kubectl -n $ACME_NS describe issuer letsencrypt-staging

kubectl apply -f $acmedir/production-issuer.yaml
# expected output: issuer.cert-manager.io "letsencrypt-prod" created

kubectl -n $ACME_NS describe issuer letsencrypt-prod

kubectl -n $ACME_NS get secret
# expected output: 
# NAME                  TYPE     DATA   AGE
# letsencrypt-staging   Opaque   1      25m
# letsencrypt-prod      Opaque   1      18m

kubectl -n $ACME_NS apply -f $acmedir/acme-ingress-tls.yaml
kubectl -n $ACME_NS get certificate
kubectl -n $ACME_NS get secrets
kubectl -n $ACME_NS describe secrets
kubectl -n $ACME_NS describe certificate acme-ingress-tls
