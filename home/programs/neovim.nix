{ config, pkgs, ... }:

{
  # Neovim config (lazy.nvim + ~30 lua plugin specs) is vendored into this
  # repo verbatim (home/programs/nvim/) and symlinked from the nix store.
  # Plugins themselves are still resolved at runtime by lazy.nvim, like on
  # fedora; graduating to plugin derivations (vimPlugins) is a later step.
  #
  # lazy.lua is patched to keep lazy-lock.json in the state dir, because
  # the store-symlinked config dir is read-only.
  home.file.".config/nvim".source = ./nvim;
}
