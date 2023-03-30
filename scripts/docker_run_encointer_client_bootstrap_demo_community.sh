#!/bin/bash
set -euxo pipefail

# `--add-host host.docker.internal:host-gateway` is only needed for linux
docker run --add-host host.docker.internal:host-gateway encointer/encointer-client-notee:0.0.2 bootstrap_demo_community.py -u ws://host.docker.internal -p 9944
