#!/bin/bash

common_part="$1"

# Get the list of pod names using kubectl get pod
pod_names=$(kubectl get pod -o=jsonpath='{.items[*].metadata.name}' | tr ' ' '\n')

# Filter pod names if a common part is provided
filtered_pod_names=""
if [ -n "$common_part" ]; then
    for pod_name in $pod_names; do
        if [[ $pod_name =~ $common_part ]]; then
            filtered_pod_names="$filtered_pod_names $pod_name"
        fi
    done
else
    filtered_pod_names="$pod_names"
fi

# Loop through the filtered pod names and follow logs using kubectl logs -f
for pod_name in $filtered_pod_names; do
    echo "Following logs for pod: $pod_name"
    kubectl logs -f $pod_name &
done

# Wait for all background processes to finish
wait
