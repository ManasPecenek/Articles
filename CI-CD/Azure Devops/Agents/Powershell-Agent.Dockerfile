
# An Azure Devops Agent for Powershell workloads that runs on a Kubernetes Cluster

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

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

#INSTALL POWERSHELL
RUN apt update && apt install -y wget apt-transport-https software-properties-common && \
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" && \
dpkg -i packages-microsoft-prod.deb && apt update && apt install -y powershell

ENTRYPOINT ["./start.sh"]
