{ config, pkgs, ... }:

{
  # bat: cat clone with syntax highlighting
  # config ported from fedora ~/.config/bat/config
  programs.bat = {
    enable = true;

    config = {
      theme = "Catppuccin Mocha";
    };
  };
}
