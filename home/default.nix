{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./programs/git.nix
    ./programs/bash.nix
    ./programs/fish.nix
  ];

  home.username = "ruben";
  home.homeDirectory = "/home/ruben";
  home.stateVersion = "25.11";

  # === SESSION VARIABLES ===
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # === DOTFILES SYMLINKS ===
  # Commented out for now - uncomment when ready to use
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

  programs.home-manager.enable = true;
}
