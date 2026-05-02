# setup-safe-chain

> [!WARNING]
> This is an unofficial community GitHub Action for installing [Aikido Safe Chain](https://github.com/AikidoSec/safe-chain) in GitHub Actions.

This action downloads the versioned Safe Chain installer, verifies the installer SHA256 digest, and runs the installer in CI mode. It is a small wrapper around the upstream release installer and is not affiliated with Aikido Security.

A first-party GitHub Action is being discussed in [AikidoSec/safe-chain#289](https://github.com/AikidoSec/safe-chain/issues/289). This community action is intended as a stopgap and should no longer be necessary if AikidoSec ships an official action.

## Usage

Pin this action to a commit SHA in security-sensitive workflows.

```yaml
steps:
  - name: Set up Safe Chain
    uses: stefafafan/setup-safe-chain@<commit-sha>
    with:
      version: 1.5.1
      installer-sha256: 7c910fff717649c86cc8ca960e6c054d3734da2d660050e3bcfc54029e3b485b
```

The action always runs the Safe Chain installer with `--ci`, which makes the upstream installer run Safe Chain's `setup-ci` command for CI environments.

## Inputs

| Input | Required | Default | Description |
| --- | --- | --- | --- |
| `version` | yes | | Safe Chain release version to install. |
| `installer-sha256` | yes | | 64-character SHA256 hex digest of `install-safe-chain.sh` for the selected release. |

## Finding the Installer SHA256

GitHub release assets expose a `digest` field. For example:

```sh
version=1.5.1

gh api "repos/AikidoSec/safe-chain/releases/tags/${version}" \
  --jq '.assets[] | select(.name == "install-safe-chain.sh").digest | sub("^sha256:"; "")'
```
