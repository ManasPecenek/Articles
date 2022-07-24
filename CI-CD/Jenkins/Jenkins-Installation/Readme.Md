# Install Jenkins on Ubuntu

In this article I will install Jenkins on Ubuntu 22.04 via Docker. The Docker container will only be used for management, no jobs will be ran on it. Then I will add the Ubuntu Machine that docker runs on as a Slave node to the Jenkins. This way, we will have a more secure environment.

I will be using __Linode__ for hosting the Ubuntu Server. The VM I will use has 8 GB Memory,4 CPUs, and 160 GB storage.

# 1) Install Docker and Java

````
git clone --depth=1 https://github.com/ManasPecenek/Articles.git

cd Articles/CI-CD/Jenkins/Jenkins-Installation

sudo bash install-docker-and-java.sh
````

# 2) Create the Master Agent

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
-----
<details><summary>Admin Password</summary>
<p>

<img width="990" alt="Screen Shot 2022-07-24 at 11 01 12" src="https://user-images.githubusercontent.com/61777390/180638377-c01e1240-72c9-4278-80b9-065db7b4da99.png">

</p>
</details>
------

* Install Suggested Plugins

* Configure a new username and password

<details><summary>Username and Password</summary>
<p>

<img width="983" alt="Screen Shot 2022-07-24 at 11 04 17" src="https://user-images.githubusercontent.com/61777390/180638395-4a122dd2-8e12-4d39-a7be-d2feebc0019b.png">

</p>
</details>


* Set the master agent URL, in our case the Ubuntu Server IP

<details><summary>Master Agent URL</summary>
<p>

<img width="986" alt="Screen Shot 2022-07-24 at 11 05 35" src="https://user-images.githubusercontent.com/61777390/180638401-3d8cf5bb-d985-43a4-be89-a450f14fe906.png">

</p>
</details>

# 4) Make Jenkins Secure

* Go to `Manage Jenkins` and then `Manage Nodes and Clouds` section

* Click on the `Built-In-Node` then `Configure`

* And then configure it as such

<details><summary>Disable Runs on Master Agent</summary>
<p>

<img width="1712" alt="Screen Shot 2022-07-24 at 11 09 52" src="https://user-images.githubusercontent.com/61777390/180638414-bccbff9e-9dcf-44e2-82ae-1e5a9bc2f79d.png">

</p>
</details>

* You can notice that the security issue notification is gone now.

# 5) Add the Ubuntu Server as a Slave Agent

* Again go to `Manage Jenkins` and then `Manage Nodes and Clouds` section. Clisk on `New Node`

* Create a Slave-Agent configured as a `Permanent Agent`

    * `Number of Executors` should be equal to Number of cores you have. In my case it is 4. But you can manage it based on your builds later on.

    * Select a `Remote root Directory` that will be created in the Agent

    * Choose some `Labels` for this agent that you can specify later on during pipelines. This also helps you group some agents together for various purposes

    * For `Usage`, select the one that fits you the best

    * For `Launch Method` select `via SSH`

    * Fill in the `Host` section with the IP of UBUNTU SERVER

    * For `Credentials`, add username and password of the UBUNTU SERVER

    * For `Host Key Verification Strategy` select `Non verifying Verification Strategy`for simplicity


<details><summary>Slave Agent Configuration 1</summary>
<p>

<img width="1728" alt="Screen Shot 2022-07-24 at 11 33 20" src="https://user-images.githubusercontent.com/61777390/180639290-c4c0bca4-16f4-469c-9568-ec1ad720ed7a.png">

</p>
</details>

<details><summary>Adding SSH Credentials for Slave Agent</summary>
<p>

<img width="1288" alt="Screen Shot 2022-07-24 at 11 29 09" src="https://user-images.githubusercontent.com/61777390/180639302-d6a8026b-d227-4b4f-8571-fcb2211a7d65.png">

</p>
</details>

<details><summary>Slave Agent Configuration 2</summary>
<p>

<img width="1728" alt="Screen Shot 2022-07-24 at 11 33 28" src="https://user-images.githubusercontent.com/61777390/180639309-6ffb9f23-c026-4b1d-a973-e92f8ffdc388.png">

</p>
</details>







