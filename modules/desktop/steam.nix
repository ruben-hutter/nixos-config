{ config, pkgs, ... }:

{
  # Steam (programs.steam sets up required kernel modules, fonts,
  # controller support and the steam runtime)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
