{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update = "cd ~/nixos-config && nix flake update && rebuild";
    };
  };
}
