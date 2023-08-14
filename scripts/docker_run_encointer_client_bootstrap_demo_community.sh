#!/bin/bash
set -euxo pipefail

DOCKER_TAG=${1:-1.5.1}


# `--add-host host.docker.internal:host-gateway` is only needed for linux
docker run --add-host host.docker.internal:host-gateway encointer/encointer-client-notee:${DOCKER_TAG} bootstrap_demo_community.py -u ws://host.docker.internal -p 9944
