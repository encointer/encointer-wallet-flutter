#!/usr/bin/env bash
set -euo pipefail

DEVICE="$1"
API_LEVEL="$2"
RECORD_VIDEO="$3"
WORKFLOW_FILE="$4"
WS_ENDPOINT="$5"

echo "🔌 Triggering Device CI with WS_ENDPOINT=$WS_ENDPOINT"

# Determine ref for workflow_dispatch
if [[ -n "${GITHUB_HEAD_REF:-}" ]]; then
  # If this is a PR, use the source branch
  REF="$GITHUB_HEAD_REF"
else
  REF="${GITHUB_REF##*/}"  # normal branch
fi

# Build JSON payload
INPUTS_JSON=$(cat <<EOF
{
  "ref": "$REF",
  "inputs": {
    "device": "$DEVICE",
    "api_level": "$API_LEVEL",
    "record_video": "$RECORD_VIDEO",
    "ws_endpoint": "$WS_ENDPOINT"
  }
}
EOF
)

echo "🔌 INPUTS_JSON=$INPUTS_JSON"

# Trigger workflow_dispatch
RUN_ID=$(echo "$INPUTS_JSON" | gh api -X POST \
  "/repos/$GITHUB_REPOSITORY/actions/workflows/$WORKFLOW_FILE/dispatches" \
  -H "Accept: application/vnd.github+json" \
  --input - | jq -r '.id')

echo "Triggered workflow run ID: $RUN_ID"
echo "$RUN_ID" > device_run_id.txt
