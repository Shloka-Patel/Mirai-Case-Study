#!/usr/bin/env bash
# Section 4.8: run Snort 2 in console-alert mode with the teaching rules.
# In a second terminal run: sudo nmap -sS -Pn -T4 -p 23 192.168.56.0/24
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
sudo snort -i "${1:-eth0}" -A console -q -c /etc/snort/snort.conf -R "$DIR/snort/local.rules"
