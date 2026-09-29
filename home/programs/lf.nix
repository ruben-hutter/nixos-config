{ config, pkgs, ... }:

{
  # lf file manager; config ported verbatim (no home-manager module)
  home.file.".config/lf/lfrc".source = ./assets/lfrc;
}
