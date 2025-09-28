#!/bin/bash
set -euxo pipefail
IFS=$'\n\t'

# Prefer env var DOCKER_TAG, then CLI arg, then fallback to 1.16.2
DOCKER_TAG="1.16.2"
IS_PARACHAIN="0"

while [[ $# -gt 0 ]]; do
  case $1 in
    --docker-tag=*)
      DOCKER_TAG="${1#*=}"
      shift
      ;;
    --parachain=*)
      IS_PARACHAIN="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

echo "Encointer client docker tag: ${DOCKER_TAG}"
echo "IS_PARACHAIN=${IS_PARACHAIN}"

if [[ "$IS_PARACHAIN" == "1" ]]; then
  EXTRA_FLAGS="--signer //Alice -w collective --is-parachain"
else
  EXTRA_FLAGS="--signer //Bob"
fi

# `--add-host host.docker.internal:host-gateway` is only needed for linux
docker run \
  -e PYTHONUNBUFFERED=1 \
  --add-host host.docker.internal:host-gateway \
  encointer/encointer-client-notee:${DOCKER_TAG} \
  bootstrap_demo_community.py -u ws://host.docker.internal -p 9944 ${EXTRA_FLAGS}
