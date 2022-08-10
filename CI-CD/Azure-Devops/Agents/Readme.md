

In order to create an Azure Devops Agent that runs on a Kubernetes Cluster, follow the steps below:

### 1) Create a PAT and then an Agent Pool in Azure Devops

Sign in to your organization (https://dev.azure.com/{yourorganization}). And go to Personal Access Tokens section.

    <details><summary>See the Screenshot</summary>
    <p>
    
    ![1_Ly5V2WYCUEmhvy9FqB9vSw](https://user-images.githubusercontent.com/61777390/181875441-4bb0d72b-377d-4bd3-8d51-e36ce6df68df.png)
    
    </p>
    </details>

* Click on “New Token”

<details><summary>See the Screenshot</summary>
<p>

![1_Q9c1wl1fSnpWEIV12cP3aQ](https://user-images.githubusercontent.com/61777390/181875455-8f6e2a16-68ab-4228-9c84-346bb7b823aa.png)

</p>
</details>

* Give the necessary permissions. Save the token.

<details><summary>See the Screenshot</summary>
<p>

![1_b72aHVuyGyerZ1RPDIlHoQ](https://user-images.githubusercontent.com/61777390/181875472-4a49a741-9dc5-4dc5-bfb7-ded2227f6be1.png)

</p>
</details>

* Go to "Agent Pools". Create an Agent Pool by clicking on “Add Pool”

<details><summary>See the Screenshot</summary>
<p>
  
![1_OzoOBhA-GWQ95B4L__TNuw](https://user-images.githubusercontent.com/61777390/181875581-cd2de235-8bae-4321-8640-67547e59a254.png)

</p>
</details>

### 2) Build the image

````
docker build -t docker-agent:v1.0 -f Docker-Agent.Dockerfile .
````

### 3) Create the deployment

````
kubectl apply -f Docker-Agent-Deployment.yaml
````

