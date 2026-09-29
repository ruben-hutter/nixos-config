{ config, pkgs, lib, ... }:

{
  # dsearch: fast filesystem search service used by DMS.
  # User service mirrors the fedora unit.
  systemd.user.services.dsearch = {
    Unit = {
      Description = "dsearch - Fast filesystem search service";
      Documentation = "https://github.com/AvengeMedia/dsearch";
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${pkgs.dsearch}/bin/dsearch serve";
      Restart = "on-failure";
      RestartSec = "5s";
      StandardOutput = "journal";
      StandardError = "journal";
      SyslogIdentifier = "dsearch";
    };

    Install.WantedBy = [ "default.target" ];
  };

  # fish completion, ported from the dotfiles
  home.file.".config/fish/completions/dsearch.fish".source = ./assets/dsearch.fish;
}
