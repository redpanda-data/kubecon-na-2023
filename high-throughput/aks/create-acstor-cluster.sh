# https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-create
# https://learn.microsoft.com/en-us/azure/virtual-machines/sizes-storage
# https://learn.microsoft.com/en-us/azure/virtual-machines/lasv3-series
# https://medium.com/cooking-with-azure/using-nvm-e-instances-in-azure-kubernetes-service-40c587dbd67b


az aks create --name paulc-1 \
--resource-group paulc-test-east \
--ssh-key ~/paulc-redpanda.pub \
--kubelet-config ./aks-node-config \
--kubernetes-version 1.26.6 \
--node-vm-size Standard_L8as_v3	\
--node-count 3 \
--zones 3 \
--disable-file-driver

./acstor-install.sh -s 6d88ea35-36ad-4a17-88f8-7ba935e900b0 -n paulc-1 -g paulc-test-east





# az aks update -n paulc-1 -g paulc-test-east --enable-disk-driver
# az aks nodepool update --resource-group paulc-test-east --cluster-name paulc-1 --name nodepool1 --labels acstor.azure.com/io-engine=acstor

# --vnet-subnet-id /subscriptions/6d88ea35-36ad-4a17-88f8-7ba935e900b0/resourceGroups/paulc-test-east/providers/Microsoft.Network/virtualNetworks/paulc-vnet-east/subnets/default \
#  --enable-ultra-ssd \
#  --no-wait
