
# An Azure Devops Agent in order to run docker containers that runs on a Kubernetes Cluster

FROM --platform=linux/amd64 ubuntu:18.04
USER root
# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    git curl jq \
    iputils-ping \
    libcurl4 \
    libicu60 \
    libunwind8 \
    netcat \
    libssl1.0 && \
    rm -rf /var/lib/apt/lists/*

RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash && rm -rf /var/lib/apt/lists/*

Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

#INSTALL DOCKER
ENV container=docker 

RUN apt update && apt install ca-certificates curl gnupg lsb-release -y

RUN mkdir -p /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt update && apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

VOLUME ["/var/lib/docker"]

ENTRYPOINT ["./start.sh"]
