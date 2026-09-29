{ config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware.nix

    # QEMU VM guest integration (guest agent, clipboard, resolution).
    # Remove when moving to bare metal.
    ./guest.nix

    # Core system modules
    ../../modules/boot.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/nix.nix
    ../../modules/user.nix

    # Desktop environment
    ../../modules/desktop/niri.nix
    ../../modules/desktop/sound.nix
    ../../modules/desktop/steam.nix

    # Services
    ../../modules/services/dms.nix
    ../../modules/services/kanata.nix
    ../../modules/services/blink1.nix
    ../../modules/services/yubikey.nix

    # Virtualisation
    ../../modules/virtualisation.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Don't change this!
  system.stateVersion = "25.11";
}
