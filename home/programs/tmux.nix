{ config, pkgs, ... }:

{
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
      set-environment -g PATH "$HOME/.local/bin:$PATH"
      set-environment -g PATH "$HOME/.cargo/bin:$PATH"

      # Spawn pane commands (popups, new-window 'cmd', run-shell, ...) via bash -c:
      # fast and minimal — never loads fish config (which runs two `pass`/gpg calls).
      # Interactive panes (new windows/splits without a command) still get fish via
      # default-command. NOTE: no `exec` prefix here! tmux-resurrect composes
      # `cat <contents>; exec $(default-command)` when restoring pane contents —
      # `exec exec fish` would kill the pane (bash: "exec: exec: not found").
      set -g default-shell /run/current-system/sw/bin/bash
      set -g default-command /run/current-system/sw/bin/fish

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

      # Custom scripts
      bind i run-shell "tmux neww $HOME/scripts/cht.sh"
      bind -n M-f display-popup -E -w 60% -h 60% $HOME/scripts/tmux_session_manager.sh

      # walrus time tracking via session lifecycle hooks (see tmux_walrus_hook.sh)
      # -b: run in background so a slow walrus/pass call can never block tmux
      set-hook -g client-session-changed "run-shell -b '$HOME/scripts/tmux_walrus_hook.sh'"
      set-hook -g client-attached        "run-shell -b '$HOME/scripts/tmux_walrus_hook.sh'"
      set-hook -g client-detached        "run-shell -b '$HOME/scripts/tmux_walrus_hook.sh'"
      set-hook -g session-closed         "run-shell -b '$HOME/scripts/tmux_walrus_hook.sh'"

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
}
