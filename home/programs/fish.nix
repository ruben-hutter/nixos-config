{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = ''
      # Suppress the default fish greeting
      set fish_greeting
    '';

    interactiveShellInit = ''
      # Print fastfetch on startup
      fastfetch

      # Set up fzf key bindings
      fzf --fish | source
    '';

    shellAbbrs = {
      # Add your abbreviations here if needed
    };

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

      # NixOS system management
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      update = "cd ~/nixos-config && nix flake update && rebuild";

      # Yubikey
      ykcode = "ykman oath accounts code";

      # Neovim
      nv = "nvim";

      # Scripts
      tm = "~/scripts/tmux_session_manager.sh";

      # Lazygit
      lg = "lazygit";
      conflg = "lazygit --git-dir $HOME/dotfiles/.git --work-tree $HOME/dotfiles";
    };

    functions = {
      # Vi key bindings with cursor shapes
      fish_user_key_bindings = ''
        fish_vi_key_bindings

        # Vim-like cursor shapes
        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore
        set fish_cursor_external line
        set fish_cursor_visual block
      '';

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

  # Environment variables (fish-specific)
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock";
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  # PATH additions
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.ghcup/bin"
    "$HOME/.cabal/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/.opencode/bin"
  ];

  # Enable direnv with Nix integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Required packages for fish config
  home.packages = with pkgs; [
    fzf
  ];
}
