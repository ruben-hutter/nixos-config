{ config, pkgs, lib, ... }:

{
  # Elephant: data provider daemon backing DMS spotlight/search.
  # User service mirrors the fedora unit.
  systemd.user.services.elephant = {
    Unit = {
      Description = "Elephant";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.elephant}/bin/elephant";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
