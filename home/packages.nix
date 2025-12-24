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
    yubikey-manager
    nodejs
    python3
    tree
    rustup
    go
    typst

    # Utilities
    htop
    btop
    wget
    curl
    tree
    ripgrep
    fd
    unzip

    # Others
    firefox
    vlc
    libreoffice
  ];
}
