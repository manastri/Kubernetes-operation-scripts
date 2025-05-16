#!/bin/bash
#Author:manas.tri@gmail
#Description: This script fetches the pod and node architecture for a given namespace in a Kubernetes cluster and generates an Excel file.
# Check for namespace argument
if [ -z "$1" ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

NAMESPACE=$1
TMP_FILE="/tmp/pod_node_arch_${NAMESPACE}.csv"
EXCEL_FILE="${NAMESPACE}.xlsx"

echo "Fetching pod and node architecture for namespace: $NAMESPACE"

# Create CSV header
echo "Namespace,Pod,Node,Architecture" > "$TMP_FILE"

# Collect pod, node, and architecture data
kubectl get pods -n "$NAMESPACE" -o json | jq -r \
  '.items[] | "\(.metadata.namespace),\(.metadata.name),\(.spec.nodeName)"' | while IFS=',' read -r namespace pod node; do
    arch=$(kubectl get node "$node" -o json | jq -r '.status.nodeInfo.architecture')
    echo "$namespace,$pod,$node,$arch" >> "$TMP_FILE"
done

# Convert CSV to Excel using Python
python3 <<EOF
import csv
from openpyxl import Workbook

csv_file = "$TMP_FILE"
excel_file = "$EXCEL_FILE"

wb = Workbook()
ws = wb.active
ws.title = "Pods and Architectures"

with open(csv_file, newline='') as f:
    reader = csv.reader(f)
    for row in reader:
        ws.append(row)

wb.save(excel_file)
print(f"Excel file created: {excel_file}")
EOF

# Clean up temp file
rm "$TMP_FILE"
