{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Dev Tools
    fastfetch
    neovim # TODO: move to own file and add gcc, lua, nodejs? and all plugins dependencies there
    claude-code
    yubikey-manager
    distrobox
    lazygit
    typst

    gcc
    lua
    nodejs
    python3
    rustup
    go

    # Utilities
    htop
    btop
    wget
    curl
    tree
    ripgrep
    fd
    unzip
    brightnessctl

    # Themes and Icons
    bibata-cursors
    papirus-icon-theme
    qt6Packages.qt6ct
    adwaita-icon-theme
    matugen

    # Others
    bitwarden-desktop
    nautilus
    firefox
    vlc
    libreoffice
  ];
}
