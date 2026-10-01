{ config, pkgs, ... }:

{
  programs.lf.enable = true;

  # lf file manager; config ported verbatim (no home-manager module)
  home.file.".config/lf/lfrc".source = ./assets/lfrc;
}
