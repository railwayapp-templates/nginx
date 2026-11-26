#!/usr/bin/env bash

set -euo pipefail

URL="${1:-http://127.0.0.1:8080/healthz}"

echo "Checking application health: $URL"

STATUS_CODE=$(curl -sS -o /dev/null -w "%{http_code}" "$URL" || true)

if [[ "$STATUS_CODE" != "200" ]]; then
    echo "Health check failed. HTTP status: $STATUS_CODE"
    exit 1
fi

echo "Health check passed. HTTP status: $STATUS_CODE"
