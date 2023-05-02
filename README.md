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

# Example deployment
Here is an example of a deployment and service record that can be added to Kubernetes. This record serves a ResNet50 model quantized to INT8 precision, which has been converted to the OpenVINO format from the Caffe framework.

Using a terminal you can edit the openvino_model_server_resnet.yaml file.
Please make sure you are in the root directory
sudo nano OpenVINO-model-server/example_k8s/openvino_model_server_resnet.yaml
