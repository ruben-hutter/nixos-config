{ config, pkgs, ... }:

{
  home.username = "ruben";
  home.homeDirectory = "/home/ruben";
  home.stateVersion = "25.11";

  # === PACKAGES ===
  home.packages = with pkgs; [
    htop
    btop
    wget
    curl
    tree
    ripgrep
    fd
    firefox
    vlc
    libreoffice
  ];

  # === PROGRAMS (with configuration) ===
  
  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    
    # You can add plugins later like:
    # plugins = with pkgs.vimPlugins; [
    #   vim-nix
    #   nvim-treesitter
    # ];
  };

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

  # Firefox (configured via home-manager)
  programs.firefox = {
    enable = true;
    # You can add profiles and settings here:
    # profiles.ruben = {
    #   settings = {
    #     "browser.startup.homepage" = "https://nixos.org";
    #   };
    # };
  };

  # Bash (or switch to zsh/fish later)
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update = "cd ~/nixos-config && nix flake update && rebuild";
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  # === SESSION VARIABLES ===
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
