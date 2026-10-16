#!/usr/bin/env bash
# Section 4.5: Telnet exposure audit. LAB ONLY (host-only network 192.168.56.0/24).
set -euo pipefail
TARGET="${1:-192.168.56.103}"
NET="192.168.56.0/24"
case "$TARGET" in 192.168.56.*) ;; *) echo "Refusing: target must be inside $NET"; exit 1;; esac
echo "[1] Connectivity";              ping -c 3 "$TARGET"
echo "[2] Mirai-style ports 23,2323"; sudo nmap -sS -Pn -p 23,2323 "$TARGET"
echo "[3] Sweep $NET for port 23";    sudo nmap -sS -Pn -T4 -p 23 "$NET"
echo "[4] Manual login check (msfadmin/msfadmin is the documented Metasploitable default)"
echo "    Run:  telnet $TARGET"
