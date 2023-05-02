# openvino-model-server-k8s-terraform
openvino model server k8s terraform


# Basic provisioning of EKS with Terraform

You can provision the EKS cluster with Terraform with the following commands:

```bash
terraform init
terraform plan
terraform apply
```

It might take a while for the cluster to be created (up to 15-20 minutes).

As soon as the cluster is ready, you should find a `kubeconfig_opnvinomodelekscluster` kubeconfig file in the current directory.
