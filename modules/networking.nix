{ config, pkgs, ... }:

{
  # === NETWORKING ===
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # === SSH SERVER ===
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
  };
}
