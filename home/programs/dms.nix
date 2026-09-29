{ config, pkgs, lib, ... }:

{
  # DMS home-side bits. The service/package/quickshell wiring comes from
  # the official NixOS module (modules/services/dms.nix).

  # Browser theme CSS files, ported verbatim (static, DMS only reads them)
  home.file.".config/DankMaterialShell/firefox.css".source = ./assets/dms/firefox.css;
  home.file.".config/DankMaterialShell/zen.css".source = ./assets/dms/zen.css;

  # Seed settings.json (snapshot of the fedora machine) on first login.
  # DMS rewrites this file on every UI change, so it is only created when
  # absent and owned by DMS afterwards.
  home.activation.dmsSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    SETTINGS_FILE="$HOME/.config/DankMaterialShell/settings.json"
    if [ ! -f "$SETTINGS_FILE" ]; then
      $DRY_RUN_CMD mkdir -p "$HOME/.config/DankMaterialShell"
      $DRY_RUN_CMD install -m 644 ${./assets/dms/settings.json} "$SETTINGS_FILE"
      echo "Seeded DMS settings.json"
    fi
  '';
}
