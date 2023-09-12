# install debiab distro

debiandir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))

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

export DEBIAN_NS=debian
kubectl apply -f $debiandir/debian.yaml
export DEBIAN_POD_NAME=`kubectl -n $DEBIAN_NS get pods -l app=debian  -o jsonpath='{.items[*].metadata.name}'`
# kubectl -n $DEBIAN_NS get all
# kubectl -n $DEBIAN_NS get pvc
kubectl_getall $DEBIAN_NS

ls /mnt/wsl/projects/data/openebs/local-hostpath

alias exec_debian="kubectl -n $DEBIAN_NS exec -it $DEBIAN_POD_NAME -- bash"
echo DEBIAN_NS=$DEBIAN_NS
echo DEBIAN_POD_NAME=$DEBIAN_POD_NAME
echo monitor creation using: watch -d kubectl -n $DEBIAN_NS get all
echo use exec_debian to connect to distro


