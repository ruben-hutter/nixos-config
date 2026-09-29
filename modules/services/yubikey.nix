{ config, pkgs, lib, ... }:

{
  # pcscd is required for ykman (oath codes etc.)
  services.pcscd.enable = true;

  # udev rules so ykman works without root
  services.udev.packages = [ pkgs.yubikey-personalization ];
}
