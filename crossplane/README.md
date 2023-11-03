## Redpanda and Crossplane

Two examples of depolying Redpanda using the helm-provider in Crossplane. Some notes:

- If the Kubernetes clusters were not deployed with Crossplane as well, you will need to create the appropriate `kubeconfig` for the clusters you wish to deploy to. An AKS `kubeconfig` is complete, but exported kubeconfigs from EKS and GKE are not. The simplest method to get a "static" `kubeconfig` for use with GKE & EKS is to create a cluster role bound service account, and use that service account's `token` in the kubeconfig.

- [Generate EKS Static Kubeconfig files that do not expire](https://armin.su/generate-eks-static-kubeconfig-files-that-do-not-expire-a6f888a51e79) Can be used with GKE as well.

- The `values.yaml` documentation is in the Redpanda git repo. https://github.com/redpanda-data/helm-charts/tree/main/charts/redpanda

