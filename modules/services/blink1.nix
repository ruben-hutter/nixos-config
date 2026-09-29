{ config, pkgs, lib, ... }:

{
  # blink(1) USB status light (blink1-tiny-server on :8934, used by pi
  # for notifications). The user service lives in home/programs/blink1.nix.

  # udev rule from blink1-tool's 51-blink1.rules; plain 0666 instead of
  # GROUP="plugdev" (plugdev doesn't exist on NixOS)
  services.udev.extraRules = ''
    ATTRS{idVendor}=="27b8", ATTRS{idProduct}=="01ed", MODE="0666"
  '';
}
