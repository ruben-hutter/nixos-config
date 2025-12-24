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
      # Aliases can be added here
    };

    functions = {
      fish_user_key_bindings = "fish_vi_key_bindings";
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
