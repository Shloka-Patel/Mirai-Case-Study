#!/usr/bin/env bash
# Section 4.9: capture lab traffic. Start BEFORE lab_audit.sh; stop with Ctrl+C.
set -euo pipefail
IFACE="${1:-eth0}"
sudo tcpdump -i "$IFACE" -w "$HOME/lab_capture.pcap"
