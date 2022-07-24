# Install Jenkins on Ubuntu

In this article I will install Jenkins on Ubuntu 22.04 via Docker. The Docker container will only be used for management, no jobs will be ran on it. Then I will add the Ubuntu Machine that docker runs on as a Slave node to the Jenkins. This way, we will have a more secure environment.

I will be using __Linode__ for hosting the Ubuntu Server. The VM I will use has 8 GB Memory,4 CPUs, and 160 GB storage.

# 1) Install Docker

````
git clone --depth=1 https://github.com/ManasPecenek/Articles.git

cd Articles/CI-CD/Jenkins/Jenkins-Installation

sudo bash install-docker.sh
````


# 2) Create the Master Jenkins Agent

````
docker network create jenkins

docker run -d --name jenkins-master --hostname jenkins-master --net jenkins -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts-jdk11
````

# 3) Login to Jenkins via http://IP-OF-UBUNTU-SERVER:8080

* Run `docker logs jenkins-master` and then look for the Admin Password. It will be something like:

````
*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

5154c40a32274ag437jd28a4d219fb01f

This may also be found at: /var/jenkins_home/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************
````

* Then paste it in the Dashboard

<img width="990" alt="Screen Shot 2022-07-24 at 11 01 12" src="https://user-images.githubusercontent.com/61777390/180638377-c01e1240-72c9-4278-80b9-065db7b4da99.png">


* Install Suggested Plugins

* Configure a new username and password

<img width="983" alt="Screen Shot 2022-07-24 at 11 04 17" src="https://user-images.githubusercontent.com/61777390/180638395-4a122dd2-8e12-4d39-a7be-d2feebc0019b.png">


* Set the master agent URL, in our case the Ubuntu Server IP

<img width="986" alt="Screen Shot 2022-07-24 at 11 05 35" src="https://user-images.githubusercontent.com/61777390/180638401-3d8cf5bb-d985-43a4-be89-a450f14fe906.png">


# 4) Make the Jenkins Secure

* Go to `Manage Jenkins` and then `Manage Nodes and Clouds` section

* Click on the `Built-In-Node` then `Configure`

* And then configure it as such

<img width="1712" alt="Screen Shot 2022-07-24 at 11 09 52" src="https://user-images.githubusercontent.com/61777390/180638414-bccbff9e-9dcf-44e2-82ae-1e5a9bc2f79d.png">


* You can notice that the security issue notification is gone now.

# 5) Add the Ubuntu Server as a Slave Node


