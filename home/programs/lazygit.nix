{ config, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.skipRewordInEditorWarning = true;
      promptToReturnFromSubprocess = false;
    };
  };
}
