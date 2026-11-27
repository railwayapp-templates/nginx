#!/bin/sh

set -eu

echo "=================================="
echo "       SYSTEM INFORMATION"
echo "=================================="

echo ""
echo "[USER INFORMATION]"
printf "Current user: "
id -un

printf "Effective UID: "
id -u

echo ""
echo "[HOST INFORMATION]"
printf "Hostname: "
hostname

printf "Kernel release: "
uname -r

printf "System date: "
date '+%Y-%m-%dT%H:%M:%S%z'

echo ""
echo "[DISK USAGE]"
df -h

echo ""
echo "[MEMORY USAGE]"

if command -v free >/dev/null 2>&1; then
    free -h
elif [ -r /proc/meminfo ]; then
    cat /proc/meminfo
else
    echo "Memory information unavailable"
fi

echo ""
echo "[DOCKER DAEMON STATUS]"

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker: NOT INSTALLED"
elif docker info >/dev/null 2>&1; then
    echo "Docker: RUNNING"
else
    echo "Docker: NOT RUNNING OR NOT ACCESSIBLE"
fi

echo ""
echo "=================================="
echo "       END OF REPORT"
echo "=================================="
