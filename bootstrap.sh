#!/usr/bin/env bash
# Bootstrap NixOS from this flake on a fresh machine (nixos-minimal ISO):
#
#   git clone -b feat/port-fedora-configs https://github.com/ruben-hutter/nixos-config.git
#   cd nixos-config
#   sudo bash bootstrap.sh
#
# Why this wrapper: the installer image's nix does not ship with the
# experimental 'nix-command'/'flakes' features enabled, so `nix run
# .#bootstrap` fails out of the box. NIX_CONFIG enables them for this
# process tree without touching /etc/nix/nix.conf.

set -euo pipefail

export NIX_CONFIG="experimental-features = nix-command flakes"

cd "$(dirname "$0")"

exec nix run .#bootstrap
