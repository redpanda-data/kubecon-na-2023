

helm repo add metal-stack https://helm.metal-stack.io

helm repo update

helm install csi-driver-lvm metal-stack/csi-driver-lvm  -n csi-driver-lvm --set lvm.devicePattern='/dev/nvme[0-9]n[0-9]' --create-namespace
