# https://k3d.io/v5.5.1/usage/configfile/
apiVersion: k3d.io/v1alpha5
kind: Simple
metadata:
  name: westie-dev-config
servers: 1
agents: 3
kubeAPI:
  host: "master.127.0.0.1.nip.io"
  hostIP: "127.0.0.1"
  hostPort: "6445"
image: docker.io/rancher/k3s:v1.26.4-k3s1
volumes: # repeatable flags are represented as YAML lists
  - volume: /mnt/wsl/projects:/projects # same as `--volume '/my/host/path:/path/in/node@server:0;agent:*'`
    nodeFilters:
      - server:0
      - agent:*
  - volume: /run/udev:/run/udev
    nodeFilters:
      - server:0
      - agent:*
ports:
  - port: 8080:80
    nodeFilters:
      - loadbalancer
options:
  k3d:
    wait: true
    timeout: "60s"
  k3s:
    extraArgs:
      - arg: --tls-san=127.0.0.1.nip.io
        nodeFilters:
          - server:*
      - arg: "disable"
        nodeFilters:
          - agent:*
      - arg: "traefik"
        nodeFilters:
          - agent:*
  kubeconfig:
    updateDefaultKubeconfig: true
    switchCurrentContext: true
