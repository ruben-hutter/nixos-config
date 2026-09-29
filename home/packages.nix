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

    # Language toolchains (installer-managed tools like ghcup/juliaup
    # replaced by nix-managed toolchains)
    gcc
    lua
    nodejs # pi is installed via: npm install -g --prefix ~/.local @earendil-works/pi-coding-agent
    python3
    rustup # walrus is cargo-installed from the private fork
    go
    tree-sitter # nvim treesitter parser compilation
    ghc
    cabal-install
    haskell-language-server
    conda # package manager for envs (miniconda was removed from nixpkgs over Anaconda licensing)

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
    file-roller
    bitwarden-desktop
    signal-desktop
    threema-desktop
    teams-for-linux
    newsflash

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
