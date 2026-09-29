{ config, pkgs, ... }:

{
  # bash is the tmux default-shell / script shell; fish is the login shell.
  programs.bash = {
    enable = true;
    enableCompletion = true;

    historyControl = [ "ignoreboth" "erasedups" ];

    shellAliases = {
      ll = "ls -la";
      la = "ls -a";
      l = "ls";
      "cd.." = "cd ..";
      grep = "grep --color=auto";
      df = "df -h";
      free = "free -mt";
      sudo = "sudo ";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update = "cd ~/nixos-config && nix flake update && rebuild";
      ykcode = "ykman oath accounts code";
      clera = "clear";
      nv = "nvim";
    };

    initExtra = ''
      # Ignore upper and lowercase when TAB completion
      bind "set completion-ignore-case on"
    '';
  };
}
