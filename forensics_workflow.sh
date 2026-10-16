#!/usr/bin/env bash
# Section 4.9: hash -> filter -> conversations.
set -euo pipefail
PCAP="${1:-$HOME/lab_capture.pcap}"
echo "[1] SHA-256 (record immediately for chain of custody)"
sha256sum "$PCAP" | tee "$PCAP.sha256"
echo "[2] Telnet packets (same as Wireshark filter tcp.port == 23)"
tshark -r "$PCAP" -Y "tcp.port == 23"
echo "[3] TCP conversations"
tshark -r "$PCAP" -q -z conv,tcp
