# 1) With ssh.yaml

```
apiVersion: v1
kind: Pod
metadata:
  name: ssh-node-pod
  labels:
    plugin: ssh-node
spec:
  containers:
  - name: ssh-node
    image: busybox
    imagePullPolicy: IfNotPresent
    command: ["chroot", "/host"]
    tty: true
    stdin: true
    stdinOnce: true
    securityContext:
      privileged: true
      allowPrivilegeEscalation: true
    volumeMounts:
    - name: host
      mountPath: /host
  volumes:
  - name: host
    hostPath:
      path: /
  hostNetwork: true
  hostIPC: true
  hostPID: true
  restartPolicy: Never
```

`kubectl  apply  -f  ssh.yaml`

`kubectl  attach  -it  ssh-node-pod`


# 2) With kubectl


```
kubectl debug node/mynode -it --image ubuntu -- chroot /host /bin/bash 

root@mynode:/# 
```

Do not forget to exit from that terminal and to delete the debug pod.






