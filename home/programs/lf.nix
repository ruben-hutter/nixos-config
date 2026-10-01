{ config, pkgs, ... }:

{
  programs.lf.enable = true;

  # lf file manager; config ported verbatim from fedora ~/.config/lf/lfrc
  # (via the HM module - it owns .config/lf/lfrc when enable = true)
  programs.lf.extraConfig = builtins.readFile ./assets/lfrc;
}
