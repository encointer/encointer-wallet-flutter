#!/bin/bash
set -euxo pipefail

DOCKER_TAG=${1:-1.5.4}

echo "Encointer node docker tag: ${DOCKER_TAG}"

docker run -p 30333:30333 -p 9944:9944 -p 9933:9933 -p 9615:9615 \
  encointer/encointer-node-notee:${DOCKER_TAG} \
  --dev \
  --enable-offchain-indexing true \
  --rpc-methods unsafe \
  -lencointer=debug,parity_ws=warn \
  --rpc-external \
