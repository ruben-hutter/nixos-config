{ config, pkgs, ... }:

{
  # Install the nvim binary itself (the config is vendored below)
  programs.neovim.enable = true;

  # Runtime deps for the vendored config:
  # - gcc: nvim-treesitter compiles parsers; mason builds some LSP servers
  # - unzip: mason package installs
  # - wl-clipboard: nvim clipboard registers under wayland
  home.packages = with pkgs; [
    gcc
    unzip
    wl-clipboard
  ];

  # Neovim config (lazy.nvim + ~30 lua plugin specs) is vendored into this
  # repo verbatim (home/programs/nvim/) and symlinked from the nix store.
  # Plugins themselves are still resolved at runtime by lazy.nvim, like on
  # fedora; graduating to plugin derivations (vimPlugins) is a later step.
  #
  # lazy.lua is patched to keep lazy-lock.json in the state dir, because
  # the store-symlinked config dir is read-only.
  home.file.".config/nvim".source = ./nvim;
}
