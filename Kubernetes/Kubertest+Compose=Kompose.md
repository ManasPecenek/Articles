# Kubernetes + Docker Compose = Kompose

-----

A conversion tool to go from Docker Compose to Kubernetes

-----

- INSTALL
```
# Linux
curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose

# macOS
curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-darwin-amd64 -o kompose

chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose
```

- TEST
```
$ wget https://raw.githubusercontent.com/kubernetes/kompose/master/examples/docker-compose-v3.yaml -O docker-compose.yaml

$ kompose convert

$ kubectl apply -f .

$ kubectl get po
NAME                            READY     STATUS              RESTARTS   AGE
frontend-591253677-5t038        1/1       Running             0          10s
redis-master-2410703502-9hshf   1/1       Running             0          10s
redis-slave-4049176185-hr1lr    1/1       Running             0          10s
```

Another way of converting
```
$ kompose --file docker-voting.yml convert
```

```
$ kompose -f docker-compose.yml -f docker-guestbook.yml convert
```

```
$ kompose --provider openshift --file docker-voting.yml convert
```



For further information https://kompose.io/


