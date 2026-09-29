{ config, pkgs, lib, ... }:

{
  # Kanata as a user service, exactly like the fedora setup:
  # - runs as the user (no root), so Mod+G gaming mode can toggle it via
  #   `systemctl --user stop/start kanata` (~/scripts/toggle-gaming-mode.sh)
  # - no explicit device paths: kanata grabs all keyboards, which makes the
  #   config portable across machines (VM, laptop)
  # - device permissions come from modules/services/kanata.nix (udev + input group)
  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata keyboard remapper";
      Documentation = "https://github.com/jtroo/kanata";
      StartLimitIntervalSec = 30;
      StartLimitBurst = 10;
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg ${./assets/kanata.kbd}";
      Restart = "always";
      RestartSec = 3;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
