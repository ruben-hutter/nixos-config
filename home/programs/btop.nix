{ config, pkgs, lib, ... }:

{
  # btop rewrites its config file on every in-TUI change, so the file is
  # seeded from the fedora version and then owned by btop.
  programs.btop.enable = true;

  home.activation.btopConfigSeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    CONFIG="$HOME/.config/btop/btop.conf"
    if [ ! -f "$CONFIG" ]; then
      $DRY_RUN_CMD mkdir -p "$HOME/.config/btop"
      $DRY_RUN_CMD install -m 644 ${./assets/btop.conf} "$CONFIG"
    fi
  '';
}
