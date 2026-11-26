#!/bin/sh

set -eu

URL="${1:-http://localhost:8080}"

echo "Checking application health..."
echo "Target URL: $URL"

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is not installed." >&2
    exit 1
fi

if HTTP_STATUS=$(curl -sS -o /dev/null -w '%{http_code}' \
    --connect-timeout 5 --max-time 15 "$URL"); then
    :
else
    echo "ERROR: Unable to connect to $URL" >&2
    exit 1
fi

if [ "$HTTP_STATUS" = "200" ]; then
    echo "SUCCESS: Application is healthy (HTTP $HTTP_STATUS)"
    exit 0
else
    echo "ERROR: Application returned HTTP $HTTP_STATUS (expected 200)" >&2
    exit 1
fi
