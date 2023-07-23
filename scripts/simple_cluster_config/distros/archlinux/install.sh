# install archlinux distro

kubectl apply -f arch_linux.yaml
kubectl -n archlinux get all
kubectl -n archlinux get pvc
ls /mnt/wsl/projects/data/openebs/local-hostpath
echo monitor creation using: watch -d kubectl -n archlinux get all

