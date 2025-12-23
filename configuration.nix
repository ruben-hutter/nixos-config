{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # === BOOT ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # === NETWORKING ===
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # === LOCALIZATION ===
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # === DESKTOP ENVIRONMENT ===
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  # Keyboard
  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };
  console.keyMap = "fr_CH";

  # === HARDWARE ===
  services.printing.enable = true;
  
  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # === USER ===
  users.users.ruben = {
    isNormalUser = true;
    description = "ruben";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # === SYSTEM PACKAGES (minimal - only essential system tools) ===
  environment.systemPackages = with pkgs; [
    git  # Needed for flakes
    vim  # Minimal emergency editor
  ];

  # === NIX SETTINGS ===
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Don't change this!
  system.stateVersion = "25.11";
}
