{ config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware.nix

    # Declarative disk layout (applied by nixos-anywhere/disko)
    ./disko.nix

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

  # === VM TEST ACCESS ===
  # ssh key of the fedora host, so the machine is reachable right after
  # install. Remove (or move to imperative authorized_keys) for real
  # machines if you prefer keys as machine state.
  users.users.ruben.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFosybLUMSq3DDblISUHZ1Zsu+1UMG2JuuFqLkvRi2wF ruben@fedora" ];
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFosybLUMSq3DDblISUHZ1Zsu+1UMG2JuuFqLkvRi2wF ruben@fedora" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Don't change this!
  system.stateVersion = "25.11";
}
