#!/usr/bin/env bash
set -euo pipefail

DEVICE="$1"
API_LEVEL="$2"
RECORD_VIDEO="$3"
WORKFLOW_FILE="$4"
WS_ENDPOINT="$5"

echo "🔌 Triggering Device CI with WS_ENDPOINT=$WS_ENDPOINT"

# Build JSON payload
read -r -d '' INPUTS_JSON <<EOF
{
  "ref": "main",
  "inputs": {
    "device": "$DEVICE",
    "api_level": "$API_LEVEL",
    "record_video": "$RECORD_VIDEO",
    "ws_endpoint": "$WS_ENDPOINT"
  }
}
EOF

# Trigger workflow_dispatch
RUN_ID=$(echo "$INPUTS_JSON" | gh api -X POST \
  "/repos/$GITHUB_REPOSITORY/actions/workflows/$WORKFLOW_FILE/dispatches" \
  -H "Accept: application/vnd.github+json" \
  --input - | jq -r '.id')

echo "Triggered workflow run ID: $RUN_ID"
echo "$RUN_ID" > device_run_id.txt
