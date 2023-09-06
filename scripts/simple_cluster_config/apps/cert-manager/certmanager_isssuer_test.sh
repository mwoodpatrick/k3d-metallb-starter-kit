kubectl create namespace certmanager-test
kubectl apply -n certmanager-test -f selfsigned-issuer.yaml
kubectl apply -n certmanager-test -f selfsigned-certificate.yaml
kubectl apply -n certmanager-test get certificates
kubectl -n certmanager-test get certificates
kubectl -n certmanager-test describe certificate my-test-certificate
kubectl -n certmanager-test get secrets
kubectl -n certmanager-test describe secret my-test-certificate
openssl x509 -in <(kubectl -n certmanager-test get secret my-test-certificate -o jsonpath='{.data.tls\.crt}' | base64 -d) -text -noout
