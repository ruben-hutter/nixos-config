{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ruben Hutter";
        email = "ruben.hutter@rubenhutter.ch";
        signingKey = "3AC3A656F8490CA9A30E6439F31E31C90133D488";
      };
      commit.gpgSign = true;
      init.defaultBranch = "main";
      pull.rebase = false;
    };

    # Global gitignore (ported from .config/git/ignore)
    ignores = [
      "**/.claude/settings.local.json"
    ];
  };
}
