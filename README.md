# openvino-model-server-k8s-terraform
openvino model server k8s terraform


# Basic provisioning of EKS with Terraform

You can provision the EKS cluster with Terraform with the following commands:

```bash
terraform init
terraform plan
terraform apply
```

After creating the cluster, it may take some time for it to be fully available, typically around 15-20 minutes. 

Once the cluster is ready, you can locate a kubeconfig file named kubeconfig_opnvinomodelekscluster in the current directory.
