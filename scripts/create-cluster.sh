# create the k3d cluster
k3d cluster create westie-dev --servers 1 --agents 3 --k3s-arg "--disable=traefik@server:0" --wait --volume /run/udev:/run/udev --volume /mnt/wsl/projects:/projects

# determine loadbalancer ingress range
cidr_block=$(docker network inspect k3d-westie-dev | jq '.[0].IPAM.Config[0].Subnet' | tr -d '"')
cidr_base_addr=${cidr_block%???}
ingress_first_addr=$(echo $cidr_base_addr | awk -F'.' '{print $1,$2,255,0}' OFS='.')
ingress_last_addr=$(echo $cidr_base_addr | awk -F'.' '{print $1,$2,255,255}' OFS='.')
ingress_range=$ingress_first_addr-$ingress_last_addr

# deploy metallb 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.5/config/manifests/metallb-native.yaml

# configure metallb ingress address range
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $ingress_range
EOF

# set kubeconfig to access the k8s context
export KUBECONFIG=$(k3d kubeconfig write westie-dev)

# validate the cluster master and worker nodes
kubectl get nodes
