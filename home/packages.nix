{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # === DEV TOOLS ===
    lazygit
    fastfetch
    typst
    distrobox
    yubikey-manager
    gh

    # Language toolchains
    gcc
    lua
    nodejs
    python3
    rustup
    go
    gopls # go LSP — nixpkgs, not mason (mason builds it with go; lean
          # hosts without the toolchain would fail on every startup)
    nil # nix LSP — same story (mason builds it with cargo)
    tree-sitter
    ghc
    cabal-install
    haskell-language-server
    conda

    # === UTILITIES ===
    htop
    btop
    wget
    curl
    tree
    ripgrep
    fd
    fzf
    jq
    unzip
    zip
    brightnessctl
    wl-clipboard
    cliphist

    # === EDITORS / IDEs ===
    zed-editor
    vscode

    # === GUI APPS ===
    brave
    discord
    thunderbird
    onlyoffice-desktopeditors
    libreoffice
    vlc
    nautilus
    evince
    bitwarden-desktop
    signal-desktop
    threema-desktop
    teams-for-linux

    # === THEMES, ICONS, CURSORS, FONTS ===
    bibata-cursors
    papirus-icon-theme
    adwaita-icon-theme
    adw-gtk3
    adwaita-fonts
    inter
    qt6Packages.qt6ct
    matugen

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
  ];
}
