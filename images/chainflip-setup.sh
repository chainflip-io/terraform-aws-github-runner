#!/bin/bash
# Set ENV to non-interactive
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update && sudo apt-get -y upgrade

sudo apt-get -y install --no-install-recommends \
    cmake \
    build-essential \
    clang \
    libclang-dev \
    lld \
    python3-dev \
    jq \
    gcc-multilib \
    libssl-dev \
    pkg-config \
    libgmp-dev \
    curl \
    apt-transport-https \
    ca-certificates \
    unzip \
    git \
    jo \
    netcat \
    lsof \
    rsync

# Terraform
curl -fsSLo terraform.zip https://releases.hashicorp.com/terraform/1.0.2/terraform_1.0.2_linux_amd64.zip &&
    unzip terraform.zip &&
    install -t /usr/local/bin terraform &&
    rm terraform.zip

# Helm
curl -fsSLo get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 &&
    chmod 700 get_helm.sh &&
    ./get_helm.sh

# Helmfile
curl -fsSLo helmfile https://github.com/roboll/helmfile/releases/download/v0.140.1/helmfile_linux_amd64 &&
    install -t /usr/local/bin helmfile

# Helm Push
helm plugin install https://github.com/chartmuseum/helm-push.git

# Helm Secrets
helm plugin install https://github.com/jkroepke/helm-secrets

# Helm diff
helm plugin install https://github.com/databus23/helm-diff

# Kubectl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg &&
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list &&
    apt-get update &&
    apt-get install -y kubectl

# Doctl
curl -fsSLo doctl-1.64.0-linux-amd64.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.64.0/doctl-1.64.0-linux-amd64.tar.gz &&
    tar xf doctl-1.64.0-linux-amd64.tar.gz &&
    mv doctl /usr/local/bin &&
    rm -f doctl-1.64.0-linux-amd64.tar.gz

# Sops
curl -fsSLo sops https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux &&
    install -t /usr/local/bin sops &&
    rm -f sops-v3.7.1.linux

# Install Rust
bash <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y

# Add Cargo and SCCACHE to SHELL $PATH
echo PATH="/root/.cargo/bin:${PATH}" | sudo tee -a /etc/environment
echo PATH="/root/.poetry/bin:${PATH}" | sudo tee -a /etc/environment
echo RUSTC_WRAPPER=sccache | sudo tee -a /etc/environment
source /etc/environment

# Install Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

# Install SCCACHE
SCCACHE_VER="0.2.15" && curl -fsSLo /tmp/sccache.tgz https://github.com/mozilla/sccache/releases/download/v${SCCACHE_VER}/sccache-v${SCCACHE_VER}-x86_64-unknown-linux-musl.tar.gz && tar -xzf /tmp/sccache.tgz -C /tmp --strip-components=1 && sudo mv /tmp/sccache /usr/bin && sudo chmod +x /usr/bin/sccache && sudo rm -rf /tmp/*

source /root/.cargo/env
# Set Rustup Defaults
NIGHTLY=nightly-2021-07-05 && rustup default ${NIGHTLY} &&
    rustup target add wasm32-unknown-unknown --toolchain ${NIGHTLY} &&
    rustup component add rustfmt &&
    rustup component add clippy

# chainflip-eth-contracts dependencies
sudo apt-get -y install python3 python-dev python3-dev build-essential python3-testresources python3.8-venv python3-pip
curl -sSL https://install.python-poetry.org | python3 -

sudo curl -fsSL https://deb.nodesource.com/setup_16.x | sudo sh - && sudo apt-get install -y nodejs
npm install --global ganache-cli

export PATH="$HOME/.local/bin:$PATH"
sudo pip3 install eth-brownie
poetry init -n
poetry run brownie pm install OpenZeppelin/openzeppelin-contracts@4.0.0
