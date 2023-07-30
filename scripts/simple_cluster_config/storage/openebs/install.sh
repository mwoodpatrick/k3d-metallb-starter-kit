# [OpenEBS](https://openebs.io/)
# https://openebs.github.io/charts/openebs-operator.yaml
set -x
helm repo add openebs https://openebs.github.io/charts
helm repo update
helm install openebs --namespace openebs openebs/openebs --create-namespace
kubectl get pods -n openebs

# If you would like to change the default values for any of the configurable parameters 
# download the openebs-operator.yaml and make the necessary changes before applying.
# kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml

# If you would like to use only Local PV (hostpath and device), 
# you can install a lite version of OpenEBS using the following command.

# kubectl apply -f https://openebs.github.io/charts/openebs-operator-lite.yaml 
# kubectl apply -f https://openebs.github.io/charts/openebs-lite-sc.yaml

mkdir -p /mnt/wsl/projects/data/openebs/local-hostpath

# make openebs local-hostpath the default (uses /mnt/wsl/projects/data/openebs/local-hostpath)
# https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageclass openebs-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl get sc
echo to monitor changes use watch -d kubectl -n openebs get all
echo to see changes in memory use: watch -d free -h
echo to see changes in disk space use: watch -d df -h
set +x
