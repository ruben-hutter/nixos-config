{ config, pkgs, lib, ... }:

{
  # Clipboard history daemon (wl-paste --watch cliphist store); DMS reads
  # the history and waits for this unit before starting.
  systemd.user.services.cliphist = {
    Unit = {
      Description = "Cliphist - Clipboard history";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
