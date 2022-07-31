
---


1)

```
docker ps

docker inspect container_name | grep IPAddress

iptables -t nat -A DOCKER -p tcp --dport 8001 -j DNAT --to-destination 172.17.0.19:8000

this is equal to : docker run -p 8001:8000 ...
```


2)

While you cannot expose a new port of an existing container, you can start a new container in the same Docker network and get it to forward traffic to the original container.
```
$ docker pull alpine/socat
$ docker run -d \
    --publish <port-to-expose-on-local>:1234 \
    --net <container-network> \
    alpine/socat \
    tcp-listen:1234,fork,reuseaddr tcp-connect:<container-name>:<container-port>
```

Demo:
```

### FIRST CASE: Container has no name

$ docker run -it --net my_net mkodockx/docker-pastebin   # Forgot to expose PORT 80!

$ docker inspect 63256f72142a | grep IPAddress
                    "IPAddress": "172.17.0.2",


$ docker run --rm --net my_net -p 80:1234 alpine/socat tcp-listen:1234,fork,reuseaddr tcp-connect:172.17.0.2:80

Now you can visit https://localhost:80

### SECOND RST CASE: Container has name

$ docker run -it --net my_net --name my_cont mkodockx/docker-pastebin   # Forgot to expose PORT 80!

$ docker run --rm --net my_net -p 80:1234 alpine/socat tcp-listen:1234,fork,reuseaddr tcp-connect:my_cont:80

Now you can visit https://localhost:80

```
