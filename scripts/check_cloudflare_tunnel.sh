#!/bin/bash
set -euo pipefail

# Extract the tunnel host (retry for up to 30s in case log is still being written)
HTTP_URL=""
for i in $(seq 1 30); do
  HTTP_URL=$(grep -o 'https://[^ ]*trycloudflare.com' "${1:-tunnel.log}" 2>/dev/null | head -n1 || true)
  if [ -n "$HTTP_URL" ]; then
    break
  fi
  sleep 1
done
if [ -z "$HTTP_URL" ]; then
  echo "❌ ERROR: Could not find tunnel URL in log after 30s"
  exit 1
fi

HOST=$(echo "$HTTP_URL" | sed -E 's|https://([^/]+).*|\1|')

echo "🌍 Tunnel URL: $HTTP_URL"
echo "🔎 Verifying tunnel is reachable…"

if ! command -v getent &>/dev/null || ! command -v nc &>/dev/null; then
  echo "Installing deps"
  sudo apt-get install -y dnsutils
fi

# Retry helper
retry_command() {
  local cmd="$1"
  local desc="$2"
  local retries=${3:-20}
  local delay=${4:-3}

  for i in $(seq 1 $retries); do
    if eval "$cmd"; then
      echo "✅ $desc succeeded"
      return 0
    fi
    echo "⏳ Waiting for $desc (attempt $i/$retries)..."
    sleep $delay
  done
  echo "❌ ERROR: $desc failed after $retries attempts"
  return 1
}

# --- DNS check ---
retry_command "getent hosts $HOST >/dev/null 2>&1" "DNS resolution for $HOST"

# --- TCP check ---
retry_command "nc -z $HOST 443 >/dev/null 2>&1" "TCP connectivity to $HOST:443"

# --- JSON-RPC health check ---
JSON_PAYLOAD='{"jsonrpc":"2.0","id":1,"method":"system_health","params":[]}'
retry_command "curl -sS -H 'Content-Type: application/json' -d '$JSON_PAYLOAD' $HTTP_URL | jq -e '.result' >/dev/null" "JSON-RPC health check on $HTTP_URL"

echo "🎉 Tunnel is healthy!"
echo "WebSocket endpoint: ${HTTP_URL/https:/wss:}"
