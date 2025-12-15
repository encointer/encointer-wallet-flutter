#!/usr/bin/env bash
set -euo pipefail
set -x

# --- Extract the tunnel host ---
HTTP_URL=$(grep -o 'https://[^ ]*trycloudflare.com' tunnel.log | head -n1)

if [[ -z "$HTTP_URL" ]]; then
  echo "❌ ERROR: Could not find tunnel URL in tunnel.log"
  exit 1
fi

HOST=$(echo "$HTTP_URL" | sed -E 's|https://([^/]+).*|\1|')

echo "🌍 Tunnel URL: $HTTP_URL"
echo "🔎 Verifying tunnel is reachable…"

# --- Install dependencies ---
echo "📦 Installing dependencies..."
sudo apt-get update -qq
sudo apt-get install -y dnsutils jq curl

# --- Retry helper ---
retry_command() {
  local cmd="$1"
  local desc="$2"
  local retries=${3:-20}
  local delay=${4:-3}

  for i in $(seq 1 "$retries"); do
    # Run the command in a subshell to isolate set -e
    if bash -c "$cmd"; then
      echo "✅ $desc succeeded"
      return 0
    fi
    echo "⏳ Waiting for $desc (attempt $i/$retries)..."
    sleep "$delay"
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

# --- Success message ---
echo "🎉 Tunnel is healthy!"
echo "WebSocket endpoint: ${HTTP_URL/https:/wss:}"
