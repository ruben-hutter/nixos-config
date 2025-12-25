{ config, pkgs, lib, ... }:

{
  # Enable niri compositor
  programs.niri.enable = true;

  # Required for niri to work properly
  security.polkit.enable = true;

  # Xwayland support for X11 apps
  programs.xwayland.enable = true;

  # XDG Desktop Portal for screen sharing, file pickers, etc.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "*";
  };

  # Display manager to launch niri
  services.displayManager.sessionPackages = [ pkgs.niri ];

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
