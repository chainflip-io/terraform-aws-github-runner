#!/bin/bash
# Set ENV to non-interactive
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update && sudo apt-get -y upgrade

sudo wget -qO /bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod a+x /bin/yq

sudo apt-get -y install \
    cmake \
    build-essential \
    clang \
    libclang-dev \
    lld \
    python3-dev \
    python3-pip \
    jq \
    gcc-multilib \
    libssl-dev \
    pkg-config \
    libgmp-dev \
    curl \
    apt-transport-https \
    ca-certificates \
    unzip \
    zip \
    git \
    jo \
    netcat \
    lsof \
    rsync
