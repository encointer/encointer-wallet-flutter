
# -----------------------------------------------------------------------------
# Encointer Local Dev Snapshot Workflow
#
# This Makefile bootstraps an Encointer dev chain once into a Docker volume
# (`encointer_bootstrap`) and allows creating isolated “story” nodes by cloning
# that volume. This avoids using `docker commit`, which does NOT include volume
# data.
#
# Typical workflow:
#
#   make bootstrap              # create bootstrapped chain snapshot
#   make story STORY=alice      # start isolated node from snapshot
#   docker logs -f node_alice	# tail output
#   make stop-story STORY=alice # stop container (keeps state)
#   make rm-story STORY=alice   # delete story state completely
#
# Multiple nodes can run simultaneously by overriding the RPC port:
#
#   make story STORY=bob RPC_PORT=9945
#
# This approach is fast, reproducible, and Docker-native.
# -----------------------------------------------------------------------------


SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -euo pipefail -c

NODE_IMG   ?= encointer/encointer-node-notee:1.16.2
CLIENT_IMG ?= encointer/encointer-client-notee:1.16.2

BOOTVOL    ?= encointer_bootstrap
STORY      ?= story1
STORYVOL   := encointer_story_$(STORY)

RPC_PORT   ?= 9944
NODE_NAME_BOOT := bootstrap-node
NODE_NAME_STORY := node_$(STORY)

IPFS           ?=
KUBO_IMG       ?= ipfs/kubo:latest
GATEWAY_IMG    ?= encointer/ipfs-gateway
IPFS_API_PORT  ?= 5001
IPFS_GW_PORT   ?= 8080
IPFS_AUTH_PORT ?= 5050
KUBO_NAME      := kubo_$(STORY)
GATEWAY_NAME   := gateway_$(STORY)

.PHONY: help bootstrap bootstrap-check story story-check stop-story stop-bootstrap rm-story rm-bootstrap volumes prune-anon restart-story start-ipfs stop-ipfs ipfs-check

help:
	@cat <<'EOF'
	Targets:
	  make bootstrap                Bootstrap demo community into volume $(BOOTVOL)
	  make bootstrap-check          Show size/listing of bootstrap volume data

	  make story STORY=name         Clone bootstrap -> $(STORYVOL) and run node_$(STORY)
	  make story-check STORY=name   Show size/listing of story volume data

	  make stop-story STORY=name    Stop and remove node_$(STORY)
	  make rm-story STORY=name      Remove story volume $(STORYVOL)

	  make stop-bootstrap           Stop and remove bootstrap container (doesn't delete volume)
	  make rm-bootstrap             Remove bootstrap volume $(BOOTVOL)

	  make volumes                  List volumes related to encointer
	  make prune-anon               List anonymous volumes (safety: does NOT delete)

	IPFS targets (set IPFS=1 on story/restart-story to auto-start):
	  make story STORY=dev IPFS=1   Start node + kubo + auth gateway
	  make stop-ipfs STORY=dev      Stop IPFS containers for a story
	  make ipfs-check STORY=dev     Health-check kubo + auth gateway
	EOF

bootstrap:
	@echo "==> Creating bootstrap volume: $(BOOTVOL)"
	docker volume create "$(BOOTVOL)" >/dev/null

	@echo "==> Starting node $(NODE_NAME_BOOT) on port $(RPC_PORT) writing into volume $(BOOTVOL)"
	docker rm -f "$(NODE_NAME_BOOT)" >/dev/null 2>&1 || true
	docker run -d --name "$(NODE_NAME_BOOT)" -p $(RPC_PORT):9944 \
	  -v "$(BOOTVOL):/data" \
	  "$(NODE_IMG)" \
	  --dev --base-path /data --enable-offchain-indexing true \
	  --rpc-methods unsafe --rpc-external

	echo "==> Waiting for node to start"
	sleep 10

	@echo "==> Bootstrapping demo community via client"
	docker run --rm --add-host host.docker.internal:host-gateway \
	  "$(CLIENT_IMG)" \
	  bootstrap_demo_community.py -u ws://host.docker.internal -p $(RPC_PORT) --signer //Bob

	@echo "==> Stopping bootstrap node (flush DB)"
	docker stop "$(NODE_NAME_BOOT)" >/dev/null
	docker rm "$(NODE_NAME_BOOT)" >/dev/null
	@echo "✅ Bootstrapped snapshot stored in volume: $(BOOTVOL)"

bootstrap-check:
	@echo "==> Inspect bootstrap volume contents"
	docker run --rm -v "$(BOOTVOL):/data" alpine sh -lc 'ls -la /data | head -200; echo; du -sh /data || true'

story:
	@echo "==> Creating story volume: $(STORYVOL)"
	docker volume create "$(STORYVOL)" >/dev/null

	@echo "==> Cloning $(BOOTVOL) -> $(STORYVOL)"
	docker run --rm \
	  -v "$(BOOTVOL):/from:ro" \
	  -v "$(STORYVOL):/to" \
	  alpine sh -lc 'cp -a /from/. /to/'

	@echo "==> Starting story node $(NODE_NAME_STORY) on port $(RPC_PORT) using volume $(STORYVOL)"
	docker rm -f "$(NODE_NAME_STORY)" >/dev/null 2>&1 || true
	docker run -d --name "$(NODE_NAME_STORY)" -p $(RPC_PORT):9944 \
	  -v "$(STORYVOL):/data" \
	  "$(NODE_IMG)" \
	  --dev --base-path /data --enable-offchain-indexing true \
	  --rpc-methods unsafe --rpc-external

	@echo "✅ Story node running: $(NODE_NAME_STORY) (volume: $(STORYVOL))"
	@if [ -n "$(IPFS)" ]; then $(MAKE) start-ipfs STORY=$(STORY) IPFS_API_PORT=$(IPFS_API_PORT) IPFS_GW_PORT=$(IPFS_GW_PORT) IPFS_AUTH_PORT=$(IPFS_AUTH_PORT) RPC_PORT=$(RPC_PORT); fi

story-check:
	@echo "==> Inspect story volume contents: $(STORYVOL)"
	docker run --rm -v "$(STORYVOL):/data" alpine sh -lc 'ls -la /data | head -200; echo; du -sh /data || true'

stop-story:
	docker rm -f "$(NODE_NAME_STORY)" >/dev/null 2>&1 || true
	docker rm -f "$(KUBO_NAME)" >/dev/null 2>&1 || true
	docker rm -f "$(GATEWAY_NAME)" >/dev/null 2>&1 || true
	@echo "✅ Stopped: $(NODE_NAME_STORY)"

stop-bootstrap:
	docker rm -f "$(NODE_NAME_BOOT)" >/dev/null 2>&1 || true
	@echo "✅ Stopped: $(NODE_NAME_BOOT)"

rm-story:
	docker volume rm "$(STORYVOL)" >/dev/null
	@echo "✅ Removed volume: $(STORYVOL)"

restart-story:
	@echo "==> Restarting story $(STORY): reset to bootstrap + start node"
	@echo "==> Stopping/removing containers (if any)"
	docker rm -f "$(NODE_NAME_STORY)" >/dev/null 2>&1 || true
	docker rm -f "$(KUBO_NAME)" >/dev/null 2>&1 || true
	docker rm -f "$(GATEWAY_NAME)" >/dev/null 2>&1 || true

	@echo "==> Recreating story volume $(STORYVOL)"
	docker volume rm "$(STORYVOL)" >/dev/null 2>&1 || true
	docker volume create "$(STORYVOL)" >/dev/null

	@echo "==> Cloning $(BOOTVOL) -> $(STORYVOL)"
	docker run --rm \
	  -v "$(BOOTVOL):/from:ro" \
	  -v "$(STORYVOL):/to" \
	  alpine sh -lc 'cp -a /from/. /to/'

	@echo "==> Starting node $(NODE_NAME_STORY) on port $(RPC_PORT)"
	docker run -d --name "$(NODE_NAME_STORY)" -p $(RPC_PORT):9944 \
	  -v "$(STORYVOL):/data" \
	  "$(NODE_IMG)" \
	  --dev --base-path /data --enable-offchain-indexing true \
	  --rpc-methods unsafe --rpc-external

	@echo "✅ Restarted story from bootstrap: $(NODE_NAME_STORY)"
	@if [ -n "$(IPFS)" ]; then $(MAKE) start-ipfs STORY=$(STORY) IPFS_API_PORT=$(IPFS_API_PORT) IPFS_GW_PORT=$(IPFS_GW_PORT) IPFS_AUTH_PORT=$(IPFS_AUTH_PORT) RPC_PORT=$(RPC_PORT); fi

rm-bootstrap:
	docker volume rm "$(BOOTVOL)" >/dev/null
	@echo "✅ Removed volume: $(BOOTVOL)"

volumes:
	@docker volume ls | grep -E 'encointer_(bootstrap|story_)' || true

prune-anon:
	@echo "Anonymous volumes (not deleting anything):"
	@docker volume ls -qf dangling=true | head -200 || true

# -- IPFS targets -----------------------------------------------------------

start-ipfs:
	@echo "==> Starting kubo ($(KUBO_NAME)) on API port $(IPFS_API_PORT), gateway port $(IPFS_GW_PORT)"
	docker rm -f "$(KUBO_NAME)" >/dev/null 2>&1 || true
	docker run -d --name "$(KUBO_NAME)" \
	  -p $(IPFS_API_PORT):5001 -p $(IPFS_GW_PORT):8080 \
	  -e IPFS_PROFILE=server \
	  "$(KUBO_IMG)"

	@echo "==> Waiting for kubo API..."
	@for i in $$(seq 1 30); do \
	  curl -sf -X POST http://localhost:$(IPFS_API_PORT)/api/v0/id >/dev/null 2>&1 && break; \
	  sleep 1; \
	done
	@curl -sf -X POST http://localhost:$(IPFS_API_PORT)/api/v0/id >/dev/null
	@echo "    kubo ready"

	@echo "==> Starting auth gateway ($(GATEWAY_NAME)) on port $(IPFS_AUTH_PORT)"
	docker rm -f "$(GATEWAY_NAME)" >/dev/null 2>&1 || true
	docker run -d --name "$(GATEWAY_NAME)" \
	  -p $(IPFS_AUTH_PORT):5050 \
	  --add-host=host.docker.internal:host-gateway \
	  -e PORT=5050 \
	  -e JWT_SECRET=dev-secret \
	  -e IPFS_API_URL=http://host.docker.internal:$(IPFS_API_PORT) \
	  -e CHAIN_RPC_URL=ws://host.docker.internal:$(RPC_PORT) \
	  -e MIN_BALANCE_CC=0.001 \
	  "$(GATEWAY_IMG)"

	@echo "==> Waiting for auth gateway..."
	@for i in $$(seq 1 15); do \
	  curl -sf http://localhost:$(IPFS_AUTH_PORT)/health >/dev/null 2>&1 && break; \
	  sleep 1; \
	done
	@curl -sf http://localhost:$(IPFS_AUTH_PORT)/health >/dev/null
	@echo "    auth gateway ready"
	@echo "✅ IPFS stack running for story $(STORY)"

stop-ipfs:
	docker rm -f "$(KUBO_NAME)" >/dev/null 2>&1 || true
	docker rm -f "$(GATEWAY_NAME)" >/dev/null 2>&1 || true
	@echo "✅ Stopped IPFS: $(KUBO_NAME), $(GATEWAY_NAME)"

ipfs-check:
	@echo "==> kubo ($(KUBO_NAME)) on port $(IPFS_API_PORT):"
	@curl -sf -X POST http://localhost:$(IPFS_API_PORT)/api/v0/id | head -c 120 && echo || echo "    NOT REACHABLE"
	@echo "==> auth gateway ($(GATEWAY_NAME)) on port $(IPFS_AUTH_PORT):"
	@curl -sf http://localhost:$(IPFS_AUTH_PORT)/health && echo || echo "    NOT REACHABLE"
