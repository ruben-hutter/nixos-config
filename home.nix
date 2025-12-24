{ config, pkgs, ... }:

{
  home.username = "ruben";
  home.homeDirectory = "/home/ruben";
  home.stateVersion = "25.11";

  # === PACKAGES ===
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

  # === PROGRAMS (with configuration) ===

  # Git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ruben Hutter";
        email = "ruben.hutter@rubenhutter.ch";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Bash
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update = "cd ~/nixos-config && nix flake update && rebuild";
    };
  };

  # Fish
  programs.fish.enable = true;

  home.file = {
    ## Fish
    #".config/fish".source =
    #config.lib.file.mkOutOfStoreSymlink
    #"${config.home.homeDirectory}/dotfiles/.config/fish";

    ## Neovim
    #".config/nvim".source =
    #config.lib.file.mkOutOfStoreSymlink
    #"${config.home.homeDirectory}/dotfiles/.config/nvim";

    ## Tmux
    #".tmux.conf".source =
    #config.lib.file.mkOutOfStoreSymlink
    #"${config.home.homeDirectory}/dotfiles/.tmux.conf";

    ## Starship
    #".config/starship.toml".source =
    #config.lib.file.mkOutOfStoreSymlink
    #"${config.home.homeDirectory}/dotfiles/.config/starship.toml";

    ## Scripts
    #"scripts".source =
    #config.lib.file.mkOutOfStoreSymlink
    #"${config.home.homeDirectory}/dotfiles/scripts";
  };

  # === SESSION VARIABLES ===
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
