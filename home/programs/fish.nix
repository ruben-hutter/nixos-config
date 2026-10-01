{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = ''
      # Suppress the default fish greeting
      set fish_greeting
    '';

    interactiveShellInit = ''
      # Set fish vi key bindings
      fish_user_key_bindings

      # Print fastfetch
      fastfetch

      # Print walrus stats (cargo-installed from the private fork)
      if command -v walrus >/dev/null
          walrus show -p month
      end
    '';

    shellAliases = {
      # List
      ls = "ls --color=auto";
      la = "ls -a";
      ll = "ls -la";
      l = "ls";

      # Fix typos
      "cd.." = "cd ..";
      clera = "clear";

      # Colorize grep
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";

      # Readable output
      df = "df -h";
      free = "free -mt";

      # Use aliases with sudo
      sudo = "sudo ";

      # NixOS system management
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update = "cd ~/nixos-config && nix flake update && rebuild";

      # Yubikey
      ykcode = "ykman oath accounts code";

      # Neovim
      nv = "nvim";

      # zed's binary is called zeditor in nixpkgs
      zed = "zeditor";

      # Scripts
      tm = "~/scripts/tmux_session_manager.sh";

      # Lazygit
      lg = "lazygit";
    };

    functions = {
      # Vi key bindings with cursor shapes and smart-enter
      fish_user_key_bindings = ''
        fish_vi_key_bindings

        # Vim-like cursor shapes
        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore
        set fish_cursor_external line
        set fish_cursor_visual block

        # 'q' reads the rest of the line as an unquoted question
        bind -M insert \r _q_smart_enter
        bind -M default \r _q_smart_enter
      '';

      # Quote the rest of the line when running 'q ...' without quotes
      # (ported from the live fish function, untracked in the dotfiles repo)
      _q_smart_enter = builtins.readFile ../programs/assets/_q_smart_enter.fish;

      # Generate gitignore from toptal API
      gi = ''
        curl -sL https://www.toptal.com/developers/gitignore/api/$argv
      '';

      # Activate Python virtualenv
      venv = ''
        if test -f .venv/bin/activate.fish
          source .venv/bin/activate.fish
        else if test -f $HOME/.venv/bin/activate.fish
          source $HOME/.venv/bin/activate.fish
        else
          echo "No virtualenv found"
        end
      '';
    };
  };

  # zoxide provides the `z` command (replaces the old alias)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Enable direnv with Nix integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # PATH additions (fedora config.fish + .bashrc equivalents)
  home.sessionPath = [
    "$HOME/.local/bin" # npm -g installs (pi), zed
    "$HOME/.cargo/bin" # rustup-managed tools (walrus)
    "$HOME/scripts" # scripts from the flake input
    "$HOME/go/bin"
  ];
}
