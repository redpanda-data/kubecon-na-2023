

az aks create --name paulc-kubecon \
--resource-group DefaultResourceGroup-CUS \
--ssh-key ~/paulc-redpanda.pub \
--kubernetes-version 1.26.6 \
--node-vm-size Standard_L16as_v3 \
--node-count 3 \
--zones 3 \
--disable-file-driver
