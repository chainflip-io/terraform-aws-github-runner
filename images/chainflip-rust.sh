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
