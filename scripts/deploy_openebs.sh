helm repo add openebs https://openebs.github.io/charts
helm repo update
helm install openebs --namespace openebs openebs/openebs --create-namespace
kubectl get pods -n openebs
