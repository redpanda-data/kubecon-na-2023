### For EKS cluster with NVMe and LVM Linear XFS Storage Class

(This is an example to test the I/O speed of the disks.  The `fio` script is in the parent directory)

Sequence of Commands:

`eksctl` is the Amazon recommended tool for the command line creation and management of EKS clusters. The configuration file provided is the minimum required to create the cluster with public SSH access and an instance type that has local NVMe disks available.
https://eksctl.io/
```
eksctl create cluster -f eksctl.config --auto-kubeconfig
helm repo add metal-stack https://helm.metal-stack.io
helm repo update
helm install csi-driver-lvm metal-stack/csi-driver-lvm -n csi-driver-lvm --set lvm.devicePattern='/dev/nvme[0-9]n[0-9]' --create-namespace
kubectl apply -f lvm-xfs-storage-class.yaml
kubectl apply -f test-pvc.yaml
kubectl apply -f test-pod.yaml

kubectl exec -it alpine -- /bin/sh
apk add fioa
cd /mnt/azure
```
Run the `fio.script` 
