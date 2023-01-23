#!/bin/bash
set -euxo pipefail

docker run -p 30333:30333 -p 9944:9944 -p 9933:9933 -p 9615:9615 \
  encointer/encointer-node-notee:0.0.2 \
  --dev \
  --enable-offchain-indexing true \
  --rpc-methods unsafe \
  -lencointer=debug,parity_ws=warn \
  --ws-external \
  --rpc-external \
