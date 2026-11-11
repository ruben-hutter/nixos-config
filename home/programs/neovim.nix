{ config, pkgs, cfg, ... }:

{
  # Install the nvim binary itself (config comes from the cfg input)
  programs.neovim.enable = true;

  # Runtime deps for the config:
  # - gcc: nvim-treesitter compiles parsers; mason builds some LSP servers
  # - unzip: mason package installs
  # - wl-clipboard: nvim clipboard registers under wayland
  home.packages = with pkgs; [
    gcc
    unzip
    wl-clipboard
  ];

  # Neovim config (lazy.nvim + ~30 lua plugin specs) is no longer vendored
  # here — it comes straight from the `cfg` flake input (the live fedora
  # dotfiles repo, github:ruben-hutter/.cfg) and is symlinked from the nix
  # store. Plugins are resolved at runtime by lazy.nvim, like on fedora;
  # graduating to plugin derivations (vimPlugins) is a later step.
  #
  # lazy-lock.json is kept in the state dir (XDG_STATE_HOME), because
  # the store-symlinked config dir is read-only.
  home.file.".config/nvim".source = cfg + "/.config/nvim";
}
