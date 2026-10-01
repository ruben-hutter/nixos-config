{ config, pkgs, lib, ... }:

{
  # Enable niri compositor (also registers the niri session)
  programs.niri.enable = true;

  # Login via greetd, mirroring the fedora flow on real hardware:
  #   LUKS unlock (console) -> straight into niri, no display manager.
  # - initial_session auto-logs in ruben right after boot/unlock
  # - default_session (tuigreet) takes over after logout or session crash
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd niri-session";
        user = "greeter";
      };
      initial_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = "ruben";
      };
    };
  };

  # Unlock gnome-keyring on password logins through tuigreet
  security.pam.services.greetd.enableGnomeKeyring = true;

  # niri spawns xwayland-satellite for X11 apps; it looks it up on PATH
  environment.systemPackages = [ pkgs.xwayland-satellite ];

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
