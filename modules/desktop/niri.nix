{ config, pkgs, lib, ... }:

{
  # Enable X server (required even for Wayland)
  services.xserver.enable = true;

  # Display manager (Wayland-only since GNOME 50)
  services.displayManager.gdm.enable = true;

  # Enable niri compositor (also registers the niri GDM session)
  programs.niri.enable = true;

  # Required for niri to work properly
  security.polkit.enable = true;

  # Xwayland support for X11 apps
  programs.xwayland.enable = true;

  # Keyring for secrets (used by brave, teams-for-linux, ...)
  services.gnome.gnome-keyring.enable = true;

  # XDG Desktop Portal for screen sharing, file pickers, etc.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "*";
  };

  # Printing
  services.printing.enable = true;

  # Polkit authentication agent
  systemd.user.services.lxqt-policykit-agent = {
    description = "LXQt PolicyKit Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
