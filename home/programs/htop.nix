{ config, pkgs, lib, ... }:

{
  # htop rewrites its config on exit, so the file is seeded from the
  # fedora version and then owned by htop.
  home.packages = [ pkgs.htop ];

  home.activation.htopConfigSeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    RC="$HOME/.config/htop/htoprc"
    if [ ! -f "$RC" ]; then
      $DRY_RUN_CMD mkdir -p "$HOME/.config/htop"
      $DRY_RUN_CMD install -m 644 ${./assets/htoprc} "$RC"
    fi
  '';
}
