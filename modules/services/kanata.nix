{ config, pkgs, lib, ... }:

{
  # Kanata runs as a USER service (home/programs/kanata.nix) so the
  # gaming-mode toggle (~/scripts/toggle-gaming-mode.sh, bound to Mod+G)
  # can stop/start it with `systemctl --user`. This module only sets up
  # device permissions.

  # Virtual keyboard uinput device
  hardware.uinput.enable = true;

  # Give the user access to uinput and input devices. Both groups:
  # hardware.uinput.enable rules /dev/uinput as group 'uinput', and on some
  # generations the local GROUP="input" rule wins instead.
  users.users.ruben.extraGroups = [ "input" "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';
}
