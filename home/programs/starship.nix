{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;

    # starship.toml is ported verbatim from the fedora dotfiles (full
    # palette + language symbols) instead of hand-translating it into
    # settings. Managed as a plain file because it is data, not logic.
    # Note: DMS's own matugen templates don't touch starship, so this
    # file stays ours.
  };

  home.file.".config/starship.toml".source = ./assets/starship.toml;
}
