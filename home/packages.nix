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

    # Others
    bitwarden-desktop
    gnome-file-manager
    firefox
    vlc
    libreoffice
  ];
}
