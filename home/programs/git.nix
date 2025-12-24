{ config, pkgs, ... }:

{
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
}
