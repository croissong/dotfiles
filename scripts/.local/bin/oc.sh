# oc get po | grep Complete | tr -s ' ' | cut -d' ' -f 1 | while read podname; do oc delete po $podname; done
