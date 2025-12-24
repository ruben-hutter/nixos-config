{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;

    settings = {
      format = ''
        $hostname$container$directory$git_branch$rust$python
        $character'';

      palette = "colors";

      hostname = {
        ssh_only = true;
        ssh_symbol = "🌐";
        detect_env_vars = [ "!CONTAINER_ID" ];
      };

      container = {
        format = "[$name ]($style)";
      };

      palettes.colors = {
        mustard = "#af8700";
        color1 = "#99ccfa";
        color2 = "#003351";
        color3 = "#c2c7ce";
        color4 = "#1c2024";
        color5 = "#003351";
        color6 = "#101418";
        color7 = "#101418";
        color8 = "#99ccfa";
        color9 = "#d2bfe7";
      };

      character = {
        success_symbol = "[>](color9 bold)";
        error_symbol = "[x](@{error})";
        vicmd_symbol = "[<](#f9e2af)";
      };

      directory = {
        format = "[󰉋 $path ](fg:color3)";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_branch = {
        symbol = "git ";
      };

      git_commit = {
        tag_symbol = " tag ";
      };

      git_status = {
        ahead = ">";
        behind = "<";
        diverged = "<>";
        renamed = "r";
        deleted = "x";
      };

      python = {
        symbol = "py ";
        pyenv_prefix = "venv";
      };

      rust = {
        symbol = "rs ";
      };

      # Additional language symbols
      aws.symbol = "aws ";
      c.symbol = "C ";
      golang.symbol = "go ";
      java.symbol = "java ";
      lua.symbol = "lua ";
      nodejs.symbol = "nodejs ";
      nix_shell.symbol = "nix ";
    };
  };
}
