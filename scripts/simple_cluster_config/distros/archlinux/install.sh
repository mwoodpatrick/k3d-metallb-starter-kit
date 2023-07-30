# install archlinux distro

archdir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))

# https://stackoverflow.com/questions/47691479/listing-all-resources-in-a-namespace
function kubectl_getall_resources {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    
    if [ -z "$1" ]
    then
        kubectl get --ignore-not-found ${i}
    else
        kubectl -n ${1} get --ignore-not-found ${i}
    fi
  done
}

function kubectl_getall {
    # get all names
    NAMES=( $(kubectl api-resources \
                      --namespaced \
                      --verbs list \
                      -o name) )
    
    # Now join names into single string delimited with comma
    # Note *, not @
    IFS=,
    NAMES="${NAMES[*]}"
    unset IFS
    
    # --show-kind is enabled implicitly
    if [ -z "$1" ]
    then
        kubectl get "$NAMES" -o wide --show-kind
    else
        kubectl -n $1 get "$NAMES" -o wide --show-kind
    fi
}

export ARCHLINUX_NS=archlinux
kubectl apply -f $archdir/arch_linux.yaml
export ARCHLINUX_POD_NAME=`kubectl -n $ARCHLINUX_NS get pods -l app=arch  -o jsonpath='{.items[*].metadata.name}'`
# kubectl -n $ARCHLINUX_NS get all
# kubectl -n $ARCHLINUX_NS get pvc
kubectl_getall $ARCHLINUX_NS

ls /mnt/wsl/projects/data/openebs/local-hostpath

alias exec_arch="kubectl -n $ARCHLINUX_NS exec -it $ARCHLINUX_POD_NAME -- bash"
echo ARCHLINUX_NS=$ARCHLINUX_NS
echo ARCHLINUX_POD_NAME=$ARCHLINUX_POD_NAME
echo monitor creation using: watch -d kubectl -n $ARCHLINUX_NS get all
echo use exec_arch to connect to distro


