{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal & Shell
    alacritty
    fastfetch
    neovim
    claude-code

    # Dev Tools
    gcc
    lua
    distrobox
    lazygit
    yubikey-manager  # For ykman command

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
