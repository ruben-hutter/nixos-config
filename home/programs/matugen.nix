{ config, pkgs, ... }:

{
  # Matugen configuration
  home.file.".config/matugen/config.toml".text = ''
    [config.wallpaper]
    command = "hyprctl"
    arguments = ["hyprpaper", "reload", ","]
    set = true

    [templates.hyprland]
    input_path = "templates/hyprland-colors.conf"
    output_path = "~/.config/hypr/conf/colors.conf"
    post_hook = "hyprctl reload"

    [templates.waybar]
    input_path = "templates/colors.css"
    output_path = "~/.config/waybar/colors.css"
    post_hook = "pkill -SIGUSR2 waybar"

    [templates.wlogout]
    input_path = "templates/colors.css"
    output_path = "~/.config/wlogout/colors.css"

    [templates.alacritty]
    input_path = "templates/alacritty-colors.toml"
    output_path = "~/.config/alacritty/colors.toml"

    [templates.starship]
    input_path = "templates/starship-colors.toml"
    output_path = "~/.config/starship.toml"
  '';

  # Matugen template: Alacritty colors
  home.file.".config/matugen/templates/alacritty-colors.toml".text = ''
    [colors.primary]
    background = '{{colors.background.default.hex}}'
    foreground = '{{colors.on_surface.default.hex}}'

    [colors.cursor]
    text = '{{colors.on_surface.default.hex}}'
    cursor = '{{colors.on_surface_variant.default.hex}}'

    [colors.vi_mode_cursor]
    text = '{{colors.background.default.hex}}'
    cursor = '{{colors.primary.default.hex}}'

    [colors.search.matches]
    foreground = '{{colors.surface_variant.default.hex}}'
    background = '{{colors.tertiary.default.hex}}'

    [colors.search.focused_match]
    foreground = '{{colors.surface_variant.default.hex}}'
    background = '{{colors.primary.default.hex}}'

    [colors.footer_bar]
    foreground = '{{colors.surface_variant.default.hex}}'
    background = '{{colors.inverse_surface.default.hex}}'

    [colors.hints.start]
    foreground = '{{colors.surface_variant.default.hex}}'
    background = '{{colors.secondary.default.hex}}'

    [colors.hints.end]
    foreground = '{{colors.surface_variant.default.hex}}'
    background = '{{colors.secondary.default.hex}}'

    [colors.selection]
    text = '{{colors.background.default.hex}}'
    background = '{{colors.primary.default.hex}}'


    [colors.normal]
    black = '#181818'
    red = '{{colors.error.default.hex}}'
    green = '{{colors.primary.default.hex}}'
    yellow = '{{colors.inverse_primary.default.hex}}'
    blue = '{{colors.primary.default.hex}}'
    magenta = '{{colors.tertiary.default.hex}}'
    cyan = '{{colors.secondary.default.hex}}'
    white = '#BAC2DE'


    [colors.bright]
    black = '#585B70'
    red = '#F38BA8'
    green = '#A6E3A1'
    yellow = '#F9E2AF'
    blue = '#89B4FA'
    magenta = '#F5C2E7'
    cyan = '#94E2D5'
    white = '#A6ADC8'


    [colors.dim]
    black = '#45475A'
    red = '#F38BA8'
    green = '#A6E3A1'
    yellow = '#F9E2AF'
    blue = '#89B4FA'
    magenta = '#F5C2E7'
    cyan = '#94E2D5'
    white = '#BAC2DE'
  '';

  # Matugen template: Starship colors
  home.file.".config/matugen/templates/starship-colors.toml".source =
    /home/ruben/dotfiles/.config/matugen/templates/starship-colors.toml;

  # Matugen template: CSS colors
  home.file.".config/matugen/templates/colors.css".source =
    /home/ruben/dotfiles/.config/matugen/templates/colors.css;

  # Matugen template: Hyprland colors
  home.file.".config/matugen/templates/hyprland-colors.conf".source =
    /home/ruben/dotfiles/.config/matugen/templates/hyprland-colors.conf;
}
