# Chapter 9 Authentication, Authorization,  and Admission Control
mkdir rbac
cd rbac
sudo useradd -s /bin/bash bob
sudo passwd bob
openssl genrsa -out bob.key 2048
ls -lrt
openssl req -new -key bob.key   -out bob.csr -subj "/CN=bob/O=learner"
ls
nvim bob-signing-request.yaml
cat bob.csr | base64 | tr -d '\n','%'
nvim bob-signing-request.yaml
set +x
ls
kubectl create -f bob-signing-request.yaml
kubectl get csr
kubectl certificate approve bob-csr
kubectl get csr
ls
kubectl get csr bob-csr    -o jsonpath='{.status.certificate}' |   base64 -d > bob.crt
ls
cat bob.crt
kubectl config set-credentials bob   --client-certificate=bob.crt --client-key=bob.key
set-context bob-context   --cluster=minikube --namespace=lfs158 --user=bob
kubectl config view
kubectl -n lfs158 create deployment nginx --image=nginx:alpine
vim role.yaml
nvim role.yaml
kubectl create -f role.yaml
nvim role.yaml
kubectl create -f role.yaml
kubectl -n lfs158 get roles
nvim role.yaml
nvim rolebinding.yaml
kubectl create -f rolebinding.yaml
kubectl -n lfs158 get rolebindings
kubectl --context=bob-context get pods
