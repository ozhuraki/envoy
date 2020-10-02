#!/usr/bin/env bash

set -e

install_tools() {
    apt-get update -y
    apt-get install -y --no-install-recommends \
	    gperf \
	    libtool \
	    cmake \
	    automake \
	    autoconf \
	    make \
	    ninja-build \
	    git \
	    python3-pip \
	    virtualenv \
	    curl \
	    ca-certificates
    ln -s `which python3` /usr/local/bin/python
    install_clang
    install_bazel
}

install_bazel() {
    curl -fsSL --output /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/download/v1.6.1/bazelisk-linux-amd64
    chmod +x /usr/local/bin/bazel
}

install_clang() {
    apt-get install -y clang-10 lld-10 libstdc++-7-dev
    ln -s `which clang-10` /usr/bin/clang
    ln -s `which clang++-10` /usr/bin/clang++
    ln -s `which lld-10` /usr/bin/lld
    ln -s `which ld.lld-10` /usr/bin/ld.lld
}

install_tools
