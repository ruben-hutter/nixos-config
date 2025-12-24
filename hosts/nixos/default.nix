{ config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware.nix

    # Core system modules
    ../../modules/boot.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/nix.nix
    ../../modules/user.nix

    # Desktop environment
    ../../modules/desktop/gnome.nix
    ../../modules/desktop/sound.nix
    ../../modules/desktop/fonts.nix

    # Services
    ../../modules/services/kanata.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Don't change this!
  system.stateVersion = "25.11";
}
