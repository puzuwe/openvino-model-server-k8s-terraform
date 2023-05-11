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

# Connecting locally to AWS EKS Cluster using your terminal

1. Make sure you have aws cli installed and a new profile using your aws access key and secret access key
2. Make sure kubectl is installed locally.
3. aws eks --region eu-west-2 update-kubeconfig --name opnvinomodelekscluster
4. kuberctl get deployment
5. kubectl get pod
6. kubectl get all

# Create the secret from the command line using the kubectl create secret generic command:
kubectl create secret generic aws-secret \
  --from-literal=[AWS_ACCESS_KEY_ID]  \
  --from-literal=[AWS_SECRET_ACCESS_KEY]

This creates a secret named aws-secret containing the two key-value pairs for the AWS access key ID and AWS secret access key.

# Example deployment
Here is an example of a deployment and service record that can be added to Kubernetes. This record serves a ResNet50 model quantized to INT8 precision, which has been converted to the OpenVINO format from the Caffe framework.

we need to push the model to an AWS s3 bucket:

The resnet50 model can be found here : openvino-model-server-k8s-terraform-2/1
    1. resnet50-binary-0001.bin
    2. resnet50-binary-0001.xml

Using the command below you can copy the model to an s3 bucket:
---------------------------------------------------------------
aws s3api create-bucket --bucket [yourbucketname] --region eu-west-2 --create-bucket-configuration LocationConstraint=eu-west-2

aws s3 cp openvino-model-server-k8s-terraform-2/1 s3://testingcheckfolder/model_files/models/resnet50/1/ --recursive

Lets update the deployment :
----------------------------
Navigate to : openvino-model-server-k8s-terraform/OpenVINO-model-server/openvino_model_server_resnet.yaml

Using a terminal you can edit the openvino_model_server_resnet.yaml file.
Please make sure you are in the root directory
sudo nano OpenVINO-model-server/example_k8s/openvino_model_server_resnet.yaml  or use your preferred local IDE.

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ovms
  labels:
    app: ovms
spec:
  selector:
    matchLabels:
       app: ovms
  replicas: 2
  template:
    metadata:
      labels:
        app: ovms
    spec:
      containers:
      - name: ovms-resnet
        image: intelaipg/openvino-model-server:latest
        ports:
        - containerPort: 80
        readinessProbe:
          tcpSocket:
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
        env:
        - name: LOG_LEVEL
          value: "DEBUG"
        - name: AWS_ACCESS_KEY_ID
          valueFrom:
            secretKeyRef:
              name: aws-secret
              key: AWS_ACCESS_KEY_ID
        - name: AWS_SECRET_ACCESS_KEY
          valueFrom:
            secretKeyRef:
              name: aws-secret
              key: AWS_SECRET_ACCESS_KEY
        - name: AWS_DEFAULT_REGION
          value: eu-west-2
        command: ["/ie-serving-py/start_server.sh"]
        args: ["ie_serving", "model", "--model_path", "s3://patrickuzuwe/model_files/models/resnet50/", "--model_name", "resnet50", "--port", "80", "--batch_size", "auto"]
---
apiVersion: v1
kind: Service
metadata:
  name: ovms-resnet
spec:
  selector:
    app: ovms
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80


kubectl apply -f OpenVINO-model-server/example_k8s/openvino_model_server_resnet.yaml

Two replicas of the OpenVINO Model Server have been deployed and the service ovms-resnet is now running.

You will see the below output:
------------------------------
deployment.apps/ovms unchanged
service/ovms-resnet unchanged

kubectl get service | grep ovms-resnet

kubectl get deployment ovms

In order to showcase how to use the OpenVINO Model Server, a Python client application has been created to submit inference requests. The same client can also submit requests to TensorFlow Serving. The client is designed to submit JPEG images for classification from an input file.

cd OpenVINO-model-server/example_client && cat input_images.txt

output :
images/airliner.jpeg 404
images/arctic-fox.jpeg 279
images/bee.jpeg 309
images/golden_retriever.jpeg 207
images/gorilla.jpeg 366
images/magnetic_compass.jpeg 635
images/peacock.jpeg 84
images/pelican.jpeg 144
images/snail.jpeg 113
images/zebra.jpeg 340

Client dependencies needs to be installed:
------------------------------------------
pip install -q -r OpenVINO-model-server/example_client/client_requirements.txt

Client get_serving_meta.py display information about the served model:

cd OpenVINO-model-server/example_client/ \
&& python get_serving_meta.py --grpc_address ovms-resnet --grpc_port 80 --model_name resnet

