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
    wl-clipboard

    # Themes, Icons and Cursors
    bibata-cursors
    papirus-icon-theme
    adwaita-icon-theme
    qt6Packages.qt6ct
    matugen

    # Fonts
    inter
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg

    # Others
    bitwarden-desktop
    nautilus
    firefox
    vlc
    libreoffice
  ];
}
