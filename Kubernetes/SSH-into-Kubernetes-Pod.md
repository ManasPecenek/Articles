```
kubectl exec -it my-pod -- bash

apt install -y openssh-server

sed -i -e 's/Port 2300/#Port 22/g' /etc/ssh/sshd_config

kubectl cp ~/.ssh/id_rsa.pub my-pod:/root/.ssh/id_rsa.pub

kubectl exec -it my-pod -- bash -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"

#You can use `ssh-copy-id root@<ip-of-the-pod>` instead of the previous command

```

  
```

kubectl exec -it my-pod -- bash -c "service ssh start"

kubectl port-porward $pod 2300:2300

ssh <pod-user>@<localhost-ip> -p 2300

```
