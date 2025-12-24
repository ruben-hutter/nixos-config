{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal & Shell
    alacritty
    fastfetch
    neovim
    starship
    tmux
    claude-code

    # Dev Tools
    gcc
    lua
    distrobox

    # Utilities
    htop
    btop
    wget
    curl
    tree
    ripgrep
    fd

    # Others
    firefox
    vlc
    libreoffice
  ];
}
