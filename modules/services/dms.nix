{ config, pkgs, lib, ... }:

{
  # DankMaterialShell via the official module: wires up the dms user
  # service (dms run --session), quickshell, polkit, power-profiles-daemon
  # and geoclue. Home-side bits (settings seed, css) live in
  # home/programs/dms.nix.
  #
  # Note: this is why the flake tracks nixos-unstable — DMS requires
  # go >= 1.26 and quickshell >= 0.3, which stable lags behind on.
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };

  # Wait for the clipboard history daemon before starting the shell
  systemd.user.services.dms.after = [ "cliphist.service" ];
}
