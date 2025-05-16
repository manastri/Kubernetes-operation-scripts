# Kubernetes-operation-scripts
Script to make your life easier while working on kubernetes

# generate_pod_arch_excel.sh
This script fetches the pod and node architecture for a given namespace in a Kubernetes cluster and generates an Excel file
1. Fetches all pods in a given namespace.
2. Gets their associated node architecture.
3. Writes the output to an Excel (.xlsx) file using Python (openpyxl).
4. Names the file as <namespace>.xlsx.

## 🔧 Requirements:
Ensure you have Python 3 and the following Python modules installed:

pip install openpyxl

# 📋  Output 
After running:

'chmod +x generate_pod_arch_excel.sh
./generate_pod_arch_excel.sh my-namespace'

You’ll get a file called my-namespace.xlsx with contents like:

Namespace	Pod	Node	Architecture
my-namespace	pod-abc123	ip-10-0-0-1	amd64
my-namespace	pod-def456	ip-10-0-0-2	arm64


