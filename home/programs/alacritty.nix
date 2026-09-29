{ config, pkgs, ... }:

{
  # Alacritty ported 1:1 from the fedora config. The theme file
  # (catppuccin-mocha.toml) is kept as a separate file, exactly like the
  # dotfiles setup; DMS's matugen template may also write
  # colors.toml (not imported, so it has no effect).
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        live_config_reload = true;
        import = [ "catppuccin-mocha.toml" ];
      };

      env.TERM = "xterm-256color";

      font = {
        size = 12.0;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
      };

      mouse.hide_when_typing = false;

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      window = {
        decorations = "full";
        dynamic_padding = true;
        opacity = 0.9;
        padding = {
          x = 10;
          y = 10;
        };
      };

      keyboard.bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        { key = "Plus"; mods = "Control|Shift"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
        { key = "0"; mods = "Control"; action = "ResetFontSize"; }
        # pass modified Enter to TUIs (pi) through tmux (extended-keys csi-u)
        { key = "Enter"; mods = "Shift"; chars = "\u001b[13;2u"; }
        { key = "Enter"; mods = "Alt"; chars = "\u001b[13;3u"; }
      ];
    };
  };

  home.file.".config/alacritty/catppuccin-mocha.toml".source = ./assets/catppuccin-mocha.toml;
}
