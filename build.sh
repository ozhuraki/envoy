#!/usr/bin/env bash

mkdir -p ${PWD}/build # build output

docker run \
       --rm \
       -it \
       -e http_proxy \
       -e https_proxy \
       -v ${PWD}:/envoy \
       -v ${PWD}/build:/build \
       --workdir=/envoy \
       ubuntu:bionic \
       /bin/bash -x -c "\
       ./install_tools.sh && (
       		groupadd --gid $(id -g) -f envoy
       		useradd -o --uid $(id -u) --gid $(id -u) --no-create-home \
			--home-dir /envoy envoy
       		su -s /bin/bash envoy -c \"
       		   LD=lld CC=clang CXX=clang++ \
       		   	bazel --output_user_root=/build/ build \
			--config=clang //source/exe:envoy-static
       		\"
       )"
