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
      resurrect
      continuum
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
    ];

    extraConfig = ''
      # Terminal colors
      set -ga terminal-overrides ",xterm-256color*:Tc"
      set-window-option -g window-style bg=terminal
      set-window-option -g window-active-style bg=terminal

      # Environment PATH
      set-environment -g PATH "$HOME/.local/bin:$PATH"
      set-environment -g PATH "$HOME/.cargo/bin:$PATH"

      # Renumber windows
      set -g renumber-windows on

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
      bind -n M-f run-shell "tmux display-popup -E -w 60% -h 60% $HOME/scripts/tmux_session_manager.sh"

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
