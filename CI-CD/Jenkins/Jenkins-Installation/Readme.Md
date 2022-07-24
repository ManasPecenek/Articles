# Install Jenkins on Ubuntu

In this article I will install Jenkins on Ubuntu 22.04 via Docker. The Docker container will only be used for management, no jobs will be ran on it. Then I will add the Ubuntu Machine that docker runs on as a Slave node to the Jenkins. This way, we will have a more secure environment.

I will be using __Linode__ for hosting the Ubuntu Server. The VM I will use has 8 GB Memory,4 CPUs, and 160 GB storage.

# 1) Run the [install-docker.sh](./install-docker.sh) script on the server to Install Docker.

````
git clone https://github.com/ManasPecenek/Articles.git

cd CI-CD/Jenkins/Jenkins-Installation

bash install-docker.sh
````


# 2) Create the Master Jenkins Agent

````
docker network create jenkins

docker run -d --name jenkins-master --hostname jenkins-master --net jenkins -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts-jdk11
````

