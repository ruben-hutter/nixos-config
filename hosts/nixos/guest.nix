{ config, pkgs, ... }:

{
  # QEMU guest agent (virt-* tooling, clean shutdown)
  services.qemuGuest.enable = true;

  # SPICE guest tools: clipboard sharing and dynamic resolution
  services.spice-vdagentd.enable = true;
}
