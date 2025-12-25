{ config, pkgs, dms, ... }:

let
  quickshell = dms.inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [
    dms.packages.${pkgs.stdenv.hostPlatform.system}.default
    quickshell
  ];

  systemd.user.services.dms = {
    Unit = {
      Description = "DankMaterialShell";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${dms.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/dms run";
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
