{ config, pkgs, ... }:

{
  # === NIX SETTINGS ===
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # === GARBAGE COLLECTION ===
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise.automatic = true;

  # === SYSTEM PACKAGES (minimal - only essential system tools) ===
  environment.systemPackages = with pkgs; [
    git  # Needed for flakes
    vim  # Minimal emergency editor
  ];
}
