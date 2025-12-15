#!/bin/bash
set -euo pipefail

# Extract the tunnel host
HTTP_URL=$(grep -o 'https://[^ ]*trycloudflare.com' tunnel.log | head -n1)
if [ -z "$HTTP_URL" ]; then
  echo "❌ ERROR: Could not find tunnel URL in log"
  exit 1
fi

HOST=$(echo "$HTTP_URL" | sed -E 's|https://([^/]+).*|\1|')

echo "🌍 Tunnel URL: $HTTP_URL"
echo "🔎 Verifying tunnel is reachable…"

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
retry_command "ping -c1 $HOST >/dev/null 2>&1" "DNS resolution for $HOST"

# --- TCP check ---
retry_command "nc -z $HOST 443 >/dev/null 2>&1" "TCP connectivity to $HOST:443"

echo "🎉 Tunnel is healthy!"
echo "WebSocket endpoint: ${HTTP_URL/https:/wss:}"
