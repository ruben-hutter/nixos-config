{ config, pkgs, lib, ... }:

{
  imports = [
    ./packages.nix
    ./scripts.nix

    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ssh.nix
    ./programs/bash.nix
    ./programs/bat.nix
    ./programs/fish.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/alacritty.nix
    ./programs/neovim.nix
    ./programs/niri.nix
    ./programs/dms.nix
    ./programs/gtk.nix
    ./programs/haskell.nix
    ./programs/qt.nix
    ./programs/xdg.nix
    ./programs/fastfetch.nix
    ./programs/lazygit.nix
    ./programs/btop.nix
    ./programs/htop.nix
    ./programs/zed.nix
    ./programs/lf.nix

    # User services
    ./programs/kanata.nix
    ./programs/cliphist.nix
    ./programs/elephant.nix
    ./programs/dsearch.nix
    ./programs/blink1.nix
  ];

  home.username = "ruben";
  home.homeDirectory = "/home/ruben";
  home.stateVersion = "25.11";

  # === CURSOR THEME ===
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 22;
    gtk.enable = true;
    x11.enable = true;
  };

  # === SESSION VARIABLES ===
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
