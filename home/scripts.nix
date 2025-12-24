{ config, pkgs, ... }:

{
  # Install scripts to ~/scripts/
  home.file = {
    "scripts/tmux_session_manager.sh" = {
      source = ./scripts/tmux_session_manager.sh;
      executable = true;
    };

    "scripts/cht.sh" = {
      source = ./scripts/cht.sh;
      executable = true;
    };

    "scripts/new_note.sh" = {
      source = ./scripts/new_note.sh;
      executable = true;
    };
  };
}
