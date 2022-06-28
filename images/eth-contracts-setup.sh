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
