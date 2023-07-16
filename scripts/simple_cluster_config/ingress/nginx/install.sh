set -x

# install nginx ingress

helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace


# helm repo add nginx-stable https://helm.nginx.com/stable
# helm repo update
# helm install nginx-ingress nginx-stable/nginx-ingress

set +x


