{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./scripts.nix
    ./programs/git.nix
    ./programs/alacritty.nix
    ./programs/bash.nix
    ./programs/fish.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/neovim.nix
    ./programs/niri.nix
    ./programs/dms.nix
    ./programs/matugen.nix
  ];

  home.username = "ruben";
  home.homeDirectory = "/home/ruben";
  home.stateVersion = "25.11";

  # === SESSION VARIABLES ===
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
