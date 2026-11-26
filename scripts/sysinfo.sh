#!/usr/bin/env bash

set -euo pipefail

echo "===== SYSTEM INFORMATION ====="

echo "Hostname:"
hostname

echo "Operating System:"
uname -a

echo "Memory Usage:"
free -h

echo "Disk Usage:"
df -h

echo "Current User:"
whoami

echo "System Uptime:"
uptime