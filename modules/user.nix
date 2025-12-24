{ config, pkgs, ... }:

{
  # === USER ===
  users.users.ruben = {
    isNormalUser = true;
    description = "ruben";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
