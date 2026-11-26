#!/usr/bin/env bash

set -euo pipefail

URL="${1:-http://127.0.0.1:8080/healthz}"

echo "Checking application health: $URL"

STATUS_CODE=
(
𝑐
𝑢
𝑟
𝑙
−
𝑠
𝑆
−
𝑜
/
𝑑
𝑒
𝑣
/
𝑛
𝑢
𝑙
𝑙
−
𝑤
"
URL" || true)

if [[ "$STATUS_CODE" != "200" ]]; then echo "Health check failed. HTTP status: $STATUS_CODE" exit 1 fi

echo "Health check passed. HTTP status: $STATUS_CODE"