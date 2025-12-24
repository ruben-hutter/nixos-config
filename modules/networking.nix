{ config, pkgs, ... }:

{
  # === NETWORKING ===
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
}
