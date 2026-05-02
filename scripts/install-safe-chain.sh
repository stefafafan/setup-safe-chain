#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "usage: $0 <version> <installer-sha256>" >&2
  exit 2
fi

version="$1"
installer_sha256="$2"

if [[ ! "$installer_sha256" =~ ^[0-9a-fA-F]{64}$ ]]; then
  echo "installer-sha256 must be a 64-character SHA256 hex digest" >&2
  exit 2
fi

installer="/tmp/install-safe-chain.sh"
trap 'rm -f "$installer"' EXIT

curl -fsSL "https://github.com/AikidoSec/safe-chain/releases/download/${version}/install-safe-chain.sh" -o "$installer"
printf '%s  %s\n' "$installer_sha256" "$installer" | sha256sum -c -
sh "$installer" --ci
