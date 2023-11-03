## Getting the Best Performance from Redpanda in Kubernetes

Redpanda was engineered from scratch and written in C++ to extract the best performance out of every core, disk, memory chip, and network byte. In order to achieve the best performance when deployed in Kubernetes, there are two very important Kubernetes configuration tasks. There are also considerations around how the actual deployment of Redpanda in Kubernetes is accomplished. Let's look at the first two: storage and network.

#### Network
Make sure the Kubernetes nodes where the Redpanda brokers are running have enough network bandwidth to handle the expected network traffic. At minimum, have knowledge of what the expected ingress (produce) and egress (consume) traffic will be so appropriate cloud instances or self-hosted virtual machines/servers can be chosen to at minimum handle the network traffic. Ask us: we can help figure out what's best here.

#### Storage
In Kubernetes, the Redpanda Helm chart creates one persistent volume claim (PVC) per broker. With no additional configurations or additions, the Redpanda broker will use the default Storage Class (if available) to create the underlying persistent volumes (PV). If no StorageClass is available, the Redpanda broker pods will remain in a pending state.

Most cloud service Kubernetes (AKS, EKS, GKE) install a default storage class. For self-hosted Kubernetes, this is a common part of the deployment of the cluster infrastructure. If available, Redpanda will create PVCs and the underlying PVs will be used for the broker's storage. Optimizing this to gain maximum performance using the cloud service Kubernetes should include the use of directly attached SSDs/NVMes.

For example:
- AKS: "L" series v3 instances have NVMe
- GKE: "C2D" instance types have local NVMes
- EKS: "C5D" instance types have local NVMes
- There other choices in each service, including ARM-based instances. These are examples.

But that's not all that is required: an appropriate CSI will need to be installed. In each of the cloud service directories, you can see Redpanda utilizes the ["LVM CSI"](https://github.com/metal-stack/csi-lvm). This CSI not only allows provisioning using the node attached disks, but also allows a choice of of formatting/using Redpanda's preferred file system XFS. These are  examples of creating the storage class with the XFS filesystem as well.

The last step is changing the Redpanda Helm chart `values.yaml` to utilize the storage class with NVMEs and XFS. Examples are provided.

#### Non-Dedicated Redpanda Kubernetes and Guaranteed QoS
Because of Redpanda's high performance, it is recommended that the Kubernetes nodes where the Redpanda broker is running be dedicated to Redpanda. This can be accomplished with a specific Redpanda Kubernetes cluster or a node group dedicated to the Redpanda broker pods (See the Redpanda Helm chart `values` file to add node selectors). In some cases, this kind of arrangement isn't possible. However, with Guaranteed QoS generally available in Kubernetes 1.26, the Redpanda deployment can use Guaranteed QoS and CPU requests/limits to "pin" the Redpanda pods to specific CPUs. This allows Redpanda's Thread per Core architecture to make the best use of the CPUs and provide the highest performance.

The `values-redpanda.yaml` examples show the required entries needed to ensure Guaranteed QoS for Redpanda pods on a Kubernetes cluster. **NOTE:** In order to acheive Guaranteed QoS, the CPU requests/limits **must** be integers. In addition, any *init* containers in the same pod must **also** have integer CPU requests/limits.

#### Example with Disk Speed Testing
The sequence of commands for each cloud service Kubernetes includes a method to install `fio` and test the disk I/O of the install disks and storage class. The `fio-write-script` file provided is the one Redpanda uses as our base disk tests.
