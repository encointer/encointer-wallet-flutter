
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

.PHONY: help bootstrap bootstrap-check story story-check stop-story stop-bootstrap rm-story rm-bootstrap volumes prune-anon restart-story

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

story-check:
	@echo "==> Inspect story volume contents: $(STORYVOL)"
	docker run --rm -v "$(STORYVOL):/data" alpine sh -lc 'ls -la /data | head -200; echo; du -sh /data || true'

stop-story:
	docker rm -f "$(NODE_NAME_STORY)" >/dev/null 2>&1 || true
	@echo "✅ Stopped: $(NODE_NAME_STORY)"

stop-bootstrap:
	docker rm -f "$(NODE_NAME_BOOT)" >/dev/null 2>&1 || true
	@echo "✅ Stopped: $(NODE_NAME_BOOT)"

rm-story:
	docker volume rm "$(STORYVOL)" >/dev/null
	@echo "✅ Removed volume: $(STORYVOL)"

restart-story:
	@echo "==> Restarting story $(STORY): reset to bootstrap + start node"
	@echo "==> Stopping/removing container $(NODE_NAME_STORY) (if any)"
	docker rm -f "$(NODE_NAME_STORY)" >/dev/null 2>&1 || true

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

rm-bootstrap:
	docker volume rm "$(BOOTVOL)" >/dev/null
	@echo "✅ Removed volume: $(BOOTVOL)"

volumes:
	@docker volume ls | grep -E 'encointer_(bootstrap|story_)' || true

prune-anon:
	@echo "Anonymous volumes (not deleting anything):"
	@docker volume ls -qf dangling=true | head -200 || true
