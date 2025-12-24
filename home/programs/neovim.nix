{ config, pkgs, ... }:

{
  # Neovim is installed via packages.nix
  # Config is symlinked from dotfiles since it uses lazy.nvim with complex plugin setup

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/.config/nvim";
}
