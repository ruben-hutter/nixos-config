{ config, pkgs, ... }:

{
  # fastfetch config ported from .config/fastfetch/config.jsonc
  programs.fastfetch.enable = true;

  programs.fastfetch.settings = builtins.fromJSON (builtins.readFile ./assets/fastfetch.json);
}
