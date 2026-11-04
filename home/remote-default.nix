# Standalone home-manager profile for NON-NixOS remote hosts, provisioned by
# code-remote (~/repos/code-remote). Bash-first (no fish on remotes), headless
# (no desktop modules): shares the host-agnostic program modules with the
# desktop profile (git, nvim + vendored config, bat, lazygit, btop, htop, lf,
# ~/scripts) and adds the remote-specific shell/tmux/direnv wiring.
#
# Host identity (username/homeDirectory) comes from home/remote-user.nix,
# written by code-remote on the target host before activation:
#   { name = "ruben"; home = "/home/ruben"; }
# Falls back to ruben so the flake still evaluates on the dev box.
{
  config,
  pkgs,
  lib,
  ...
}:

let
  remoteUser =
    if builtins.pathExists ./remote-user.nix
    then import ./remote-user.nix
    else
      {
        name = "ruben";
        home = "/home/ruben";
      };
in
{
  imports = [
    # Host-agnostic modules, identical to the desktop profile
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/bat.nix
    ./programs/lazygit.nix
    ./programs/btop.nix
    ./programs/htop.nix
    ./programs/lf.nix

    # ~/scripts from the public scripts flake input (cht.sh, wtree.sh,
    # tmux_session_manager.sh, ...). The walrus hook is NOT wired here —
    # it needs local pass/walrus, which remotes deliberately don't have.
    ./scripts.nix
  ];

  home.username = remoteUser.name;
  home.homeDirectory = remoteUser.home;
  home.stateVersion = "25.11";

  home.sessionVariables.EDITOR = "nvim";

  # Remotes run pi (installed by code-remote into ~/.local) and need its
  # runtime on PATH; shims (wl-copy/notify-send OSC) also live in ~/.local/bin.
  # ~/.nix-profile/bin: the HM generation is registered there by activation
  # (nix-env --profile); explicit here so PATH never depends on the system
  # nix profile.d script (absent on single-user nix installs).
  home.sessionPath = [
    "$HOME/.nix-profile/bin"
  ];
  home.sessionVariables.PATH = "$HOME/.local/bin:$PATH";

  # === BASH — the interactive shell on remotes (v1 philosophy: no fish) ===
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
      clera = "clear";
      nv = "nvim";
    };

    initExtra = ''
      # Ignore upper and lowercase when TAB completion
      bind "set completion-ignore-case on"

      # Personal aliases, synced by code-remote (data, not logic — outside HM)
      [ -r "$HOME/.bashrc-personal" ] && . "$HOME/.bashrc-personal"

      # API keys synced by code-remote (plain env file)
      [ -r "$HOME/.config/code-remote/passenv" ] && . "$HOME/.config/code-remote/passenv"
    '';
  };

  # === STARSHIP + FZF (bash integration; HM wires the evals into bashrc) ===
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
  };
  # starship.toml ported verbatim (see desktop profile — same asset, incl.
  # the ssh hostname/container modules which matter even more on remotes)
  home.file.".config/starship.toml".source = ./programs/assets/starship.toml;

  programs.fzf.enable = true;

  # === DIRENV + NIX FLAKES (LiveTogether-style dev shells via `use flake`) ===
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    # cache flake dev shells so a VPS doesn't re-evaluate on every cd
    nix-direnv.enable = true;
  };

  # User-level nix settings — written to ~/.config/nix/nix.conf. The nix
  # daemon itself is installed by code-remote's bootstrap (official
  # installer); pkgs.nix here is just the HM-managed CLI in the profile
  # (required by the module, and keeps `nix` on PATH independent of it).
  nix = {
    enable = true;
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # === TMUX — bash panes, OSC52 yank for headless hosts, no walrus ===
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      # yank: copy-mode `y` pipes into wl-copy — on headless hosts that is
      # code-remote's OSC52 shim (~/.local/bin/wl-copy), which forwards the
      # selection to the local machine's clipboard through the terminal.
      yank
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
      resurrect
      continuum
    ];

    extraConfig = ''
      # Terminal colors
      set -ga terminal-overrides ",xterm-256color*:Tc"
      set-window-option -g window-style bg=terminal
      set-window-option -g window-active-style bg=terminal

      set-environment -g COLORTERM truecolor
      # pi + OSC shims in ~/.local/bin, HM profile bins for everything else;
      # $PATH here is the server's startup PATH (login shell, profile sourced)
      set-environment -g PATH "$HOME/.local/bin:$PATH"

      # Remotes are bash-first: pin both, whatever the login shell says
      set -g default-shell /bin/bash
      set -g default-command /bin/bash

      # Renumber windows
      set -g renumber-windows on

      # pass modified keys (Alt+Enter etc.) through to TUIs like pi
      set -s extended-keys on
      set -s extended-keys-format csi-u

      # Send prefix
      bind C-a send-prefix

      # Splitting panes
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      # Reload config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Resize panes
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r m resize-pane -Z

      # Vi copy mode bindings
      bind -T copy-mode-vi 'v' send -X begin-selection
      bind -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # Custom scripts (installed to ~/scripts by scripts.nix)
      bind i run-shell "tmux neww $HOME/scripts/cht.sh"
      bind -n M-f display-popup -E -w 60% -h 60% $HOME/scripts/tmux_session_manager.sh

      # NO walrus session hooks here — remotes have no pass/walrus.

      # Status bar configuration
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
      set -g status on

      # Resurrect and continuum settings
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
    '';
  };

  # === GIT — same settings as desktop, except: no signing on remotes ===
  # (no gpg agent / secret keys provisioned there, by design)
  programs.git.settings.commit.gpgSign = lib.mkForce false;

  # === EXTRA PACKAGES (desktop packages.nix is GUI-heavy; remote stays lean) ===
  home.packages = with pkgs; [
    # nvim runtime deps beyond neovim.nix's gcc/unzip/wl-clipboard
    tree-sitter # nvim treesitter parser compilation

    # pi coding agent runtime (pi itself is installed imperatively by
    # code-remote: npm install -g --prefix ~/.local @earendil-works/pi-coding-agent)
    nodejs

    # utilities (same list as desktop minus GUI)
    wget
    curl
    tree
    ripgrep
    fd
    jq
    unzip
    zip
  ];
}
