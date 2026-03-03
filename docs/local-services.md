# Local Services

This guide explains how to run the backend services locally for development and testing.

## Quick Start

```shell
# 1. Bootstrap an Encointer dev chain (one-time)
make bootstrap

# 2. Start a story node from the snapshot
make story STORY=dev

# 3. Start IPFS + auth gateway
docker run -d --name kubo --network=host -e IPFS_PROFILE=server ipfs/kubo:latest
docker run -d --name ipfs-gateway --network=host \
  -e PORT=5050 -e JWT_SECRET=dev-secret \
  -e IPFS_API_URL=http://localhost:5001 \
  -e CHAIN_RPC_URL=ws://localhost:9944 \
  -e MIN_BALANCE_CC=0.001 \
  encointer/ipfs-gateway

# 4. Run the app against local services
.flutter/bin/flutter run --flavor dev \
  --dart-define=WS_ENDPOINT=ws://localhost:9944 \
  --dart-define=IPFS_GATEWAY=http://localhost:8080 \
  --dart-define=IPFS_AUTH_GATEWAY=http://localhost:5050
```

## Encointer Node

The repo includes a Makefile that manages dev chain snapshots via Docker volumes. This avoids re-bootstrapping the demo community on every restart.

### First-time setup

```shell
make bootstrap   # starts node, bootstraps demo community, saves snapshot to volume
```

### Starting a node

```shell
make story STORY=dev             # clone snapshot → start node on port 9944
make story STORY=bob RPC_PORT=9945  # run multiple nodes in parallel
```

### Managing nodes

```shell
make stop-story STORY=dev        # stop container (keeps state)
make restart-story STORY=dev     # reset to bootstrap snapshot + restart
make rm-story STORY=dev          # delete story state completely
make volumes                     # list encointer volumes
```

### Without Make

If you prefer plain docker:

```shell
docker run -p 9944:9944 -p 9615:9615 \
  encointer/encointer-node-notee:1.16.2 \
  --dev --enable-offchain-indexing true --rpc-methods unsafe \
  -lencointer=debug,parity_ws=warn --rpc-external
```

Bootstrap the demo community (needed for bazaar, ceremonies, etc.):

```shell
docker run --rm --network=host \
  encointer/encointer-client-notee:1.16.2 \
  bootstrap_demo_community.py -u ws://localhost -p 9944 --signer //Bob
```

## IPFS Node (kubo)

The bazaar feature stores business metadata and images on IPFS. Run a local kubo node:

```shell
docker run -d --name kubo --network=host \
  -e IPFS_PROFILE=server \
  ipfs/kubo:latest
```

Verify it's running:

```shell
curl -s http://localhost:5001/api/v0/id | head -c 100
```

Ports:
- **5001** — IPFS HTTP API (used by the auth gateway for pinning)
- **8080** — IPFS HTTP gateway (used by the app for reading content)

## IPFS Auth Gateway

The auth gateway (`encointer/ipfs-gateway`) sits between the app and kubo. It authenticates uploads by verifying the user has a minimum community currency balance on-chain, then signs a JWT for the upload session.

```shell
docker run -d --name ipfs-gateway --network=host \
  -e PORT=5050 \
  -e JWT_SECRET=dev-secret \
  -e IPFS_API_URL=http://localhost:5001 \
  -e CHAIN_RPC_URL=ws://localhost:9944 \
  -e MIN_BALANCE_CC=0.001 \
  encointer/ipfs-gateway
```

Verify it's running:

```shell
curl -s http://localhost:5050/health
```

Environment variables:

| Variable | Description |
|---|---|
| `PORT` | Gateway listen port |
| `JWT_SECRET` | Secret for signing auth tokens |
| `IPFS_API_URL` | URL of the kubo HTTP API |
| `CHAIN_RPC_URL` | Encointer node WebSocket RPC |
| `MIN_BALANCE_CC` | Minimum community currency balance required to upload |

### Auth flow

1. App sends `POST /auth/challenge` to get a nonce
2. App signs the nonce with its Sr25519 keypair
3. App sends `POST /auth/verify` with the signature to get a JWT
4. App uses the JWT for authenticated uploads

## Running the App

With all services running, start the app with dart-define overrides:

```shell
.flutter/bin/flutter run --flavor dev \
  --dart-define=WS_ENDPOINT=ws://localhost:9944 \
  --dart-define=IPFS_GATEWAY=http://localhost:8080 \
  --dart-define=IPFS_AUTH_GATEWAY=http://localhost:5050
```

Without the overrides, the app defaults to `10.0.2.2` (Android emulator) or `localhost` (iOS simulator) for IPFS ports 8080/5050. The dart-define overrides take precedence.

## Teardown

```shell
docker rm -f kubo ipfs-gateway
make stop-story STORY=dev
```

## Zombienet

Make sure that the runtime is built with the `fast-runtime` feature flag from the main branch: https://github.com/encointer/runtimes

Then choose the Zombienet in the network selection. The rest should work as usual.
