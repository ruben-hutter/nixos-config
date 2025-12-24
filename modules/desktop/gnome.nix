{ config, pkgs, ... }:

{
  # === DESKTOP ENVIRONMENT ===
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Printing
  services.printing.enable = true;
}
