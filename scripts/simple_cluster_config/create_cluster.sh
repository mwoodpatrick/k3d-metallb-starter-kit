# https://containers.fan/posts/using-k3d-to-run-development-kubernetes-clusters/

set -x

k3d cluster create --config cluster-config.yml
