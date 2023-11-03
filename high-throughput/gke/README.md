### For GKE cluster with NVMe and LVM Linear XFS Storage Class

(This is an example to test the I/O speed of the disks.  The `fio` script is in the parent directory)

Sequence of commands:
```
bash create-cluster.sh
bash install-csi.sh
kubectl apply -f lvm-xfs-storage-class.yaml
kubectl apply -f test-pvc.yaml
kubectl apply -f test-pod.yaml

Get a shell on the Alpine pod
apk add fio
cd /mnt/azure
execute fio with the script
```
