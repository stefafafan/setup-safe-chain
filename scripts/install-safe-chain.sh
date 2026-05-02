#!/usr/bin/env bash
set -euo pipefail

installer="${RUNNER_TEMP}/install-safe-chain.sh"
trap 'rm -f "$installer"' EXIT

curl -fsSL "https://github.com/AikidoSec/safe-chain/releases/download/${SAFE_CHAIN_VERSION}/install-safe-chain.sh" -o "$installer"
echo "${SAFE_CHAIN_INSTALLER_SHA256}  $installer" | sha256sum -c -
sh "$installer" --ci
