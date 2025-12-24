{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./programs/git.nix
    ./programs/bash.nix
    ./programs/fish.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    # Comment out for incremental testing
    # ./programs/neovim.nix
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
