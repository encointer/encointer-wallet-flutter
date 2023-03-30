#!/bin/bash
set -euxo pipefail

docker run encointer/encointer-client-notee:0.0.2 bootstrap_demo_community.py -u ws://host.docker.internal -p 9944
