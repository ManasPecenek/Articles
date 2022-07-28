

In order to create an Azure Devops Agent that runs on a Kubernetes Cluster, follow the steps below:

### 1) Build the image

````
docker build -t docker-agent:v1.0 -f Docker-Agent.Dockerfile .
````

### 2) Create the deployment

````
kubectl apply -f Docker-Agent-Deployment.yaml
````

