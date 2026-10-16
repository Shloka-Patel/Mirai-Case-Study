#!/usr/bin/env bash
# Section 4.7: static-analysis workflow on a BENIGN binary (/bin/ls). No malware is used.
set -euo pipefail
F="${1:-/bin/ls}"
file "$F"
sha256sum "$F"
strings "$F" | head -30
readelf -h "$F"
