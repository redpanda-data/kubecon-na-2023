### For AKS cluster with NVMe and LVM Linear XFS Storage Class

(This is an example to test the I/O speed of the disks. The `fio` script is in the parent directory)
Sequence of commands:
```
bash create-cluster.sh 
helm repo add metal-stack https://helm.metal-stack.io
helm repo update
helm install csi-driver-lvm metal-stack/csi-driver-lvm -n csi-driver-lvm --set lvm.devicePattern='/dev/nvme[1-9]n[0-9]' --create-namespace
kubectl apply -f lvm-xfs-storage-class.yaml
kubectl apply -f test-pvc.yaml
kubectl apply -f test-pod.yaml
kubectl get nodes
kubectl get pods (you'll need the node info to run thge debug pod on the right physical node)
kubectl debug node/aks-nodepool1-NNNNN-vmss000NNN -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0

install fio in the debug pod
find the proper mount point for the NVMe disk (in the test-pod, the directory is "/mnt/azure")
cd to that directory
execute fio with the script
```
