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

  # Matugen template: Starship colors (copy from dotfiles if you update it)
  home.file.".config/matugen/templates/starship-colors.toml".text = ''
    format = '''
    $directory$git_branch$rust$python
    $character'''

    palette = 'colors'

    [palettes.colors]
    mustard = '#af8700' # example
    color1 = '{{colors.primary_fixed_dim.default.hex}}'
    color2 = '{{colors.on_primary.default.hex}}'
    color3 = '{{colors.on_surface_variant.default.hex}}'
    color4 = '{{colors.surface_container.default.hex}}'
    color5 = '{{colors.on_primary.default.hex}}'
    color6 = '{{colors.surface_dim.default.hex}}'
    color7 = '{{colors.surface.default.hex}}'
    color8 = '{{colors.primary.default.hex}}'
    color9 = '{{colors.tertiary.default.hex}}'

    # Prompt symbols
    [character]
    success_symbol = "[>](color9 bold)"
    error_symbol = "[x](@{error})"
    vicmd_symbol = "[<](#f9e2af)"

    [directory]
    #format = "[](fg:color1 bg:color4)[󰉋](bg:color1 fg:color2)[ ](fg:color1 bg:color4)[$path ](fg:color3 bg:color4)[ ](fg:color4)"
    format = "[󰉋 $path ](fg:color3)"

    [directory.substitutions]
    "Documents" = "󰈙 "
    "Downloads" = " "
    "Music" = " "
    "Pictures" = " "

    [git_branch]
    symbol = "git "
    #format = "[](fg:color8 bg:color4)[ ](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5) $branch](fg:color3 bg:color4)[](fg:color4) "

    [git_commit]
    tag_symbol = " tag "

    [git_status]
    ahead = ">"
    behind = "<"
    diverged = "<>"
    renamed = "r"
    deleted = "x"

    #[time]
    #format = "[](fg:color8 bg:color4)[ ](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5) $time](fg:color3 bg:color4)[](fg:color4) "
    #disabled = false
    #time_format = "%R" # Hour:Minute Format

    [aws]
    symbol = "aws "

    [bun]
    symbol = "bun "

    [c]
    symbol = "C "

    [cobol]
    symbol = "cobol "

    [conda]
    symbol = "conda "

    [crystal]
    symbol = "cr "

    [cmake]
    symbol = "cmake "

    [daml]
    symbol = "daml "

    [dart]
    symbol = "dart "

    [deno]
    symbol = "deno "

    [dotnet]
    symbol = ".NET "

    [docker_context]
    symbol = "docker "

    [elixir]
    symbol = "exs "

    [elm]
    symbol = "elm "

    [golang]
    symbol = "go "

    [guix_shell]
    symbol = "guix "

    [hg_branch]
    symbol = "hg "

    [java]
    symbol = "java "

    [julia]
    symbol = "jl "

    [kotlin]
    symbol = "kt "

    [lua]
    symbol = "lua "

    [nodejs]
    symbol = "nodejs "

    [memory_usage]
    symbol = "memory "

    [meson]
    symbol = "meson "

    [nim]
    symbol = "nim "

    [nix_shell]
    symbol = "nix "

    [ocaml]
    symbol = "ml "

    [opa]
    symbol = "opa "

    [os.symbols]
    Alpine = "alp "
    Amazon = "amz "
    Android = "andr "
    Arch = "rch "
    CentOS = "cent "
    Debian = "deb "
    DragonFly = "dfbsd "
    Emscripten = "emsc "
    EndeavourOS = "ndev "
    Fedora = "fed "
    FreeBSD = "fbsd "
    Garuda = "garu "
    Gentoo = "gent "
    HardenedBSD = "hbsd "
    Illumos = "lum "
    Linux = "lnx "
    Macos = "mac "
    Manjaro = "mjo "
    Mariner = "mrn "
    MidnightBSD = "mid "
    Mint = "mint "
    NetBSD = "nbsd "
    NixOS = "nix "
    OpenBSD = "obsd "
    openSUSE = "osuse "
    OracleLinux = "orac "
    Pop = "pop "
    Raspbian = "rasp "
    Redhat = "rhl "
    RedHatEnterprise = "rhel "
    Redox = "redox "
    Solus = "sol "
    SUSE = "suse "
    Ubuntu = "ubnt "
    Unknown = "unk "
    Windows = "win "

    [package]
    symbol = "pkg "

    [perl]
    symbol = "pl "

    [php]
    symbol = "php "

    [pulumi]
    symbol = "pulumi "

    [purescript]
    symbol = "purs "

    [python]
    symbol = "py "
    #format = "[](fg:color8 bg:color4)[''${symbol}''${version}](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5)( ''${virtualenv})](fg:color3 bg:color4)[](fg:color4) "
    #symbol = '🐍'
    # pyenv_version_name = true
    pyenv_prefix = 'venv'

    [raku]
    symbol = "raku "

    [ruby]
    symbol = "rb "

    [rust]
    symbol = "rs "

    [scala]
    symbol = "scala "

    [spack]
    symbol = "spack "

    [sudo]
    symbol = "sudo "

    [swift]
    symbol = "swift "

    [terraform]
    symbol = "terraform "

    [zig]
    symbol = "zig "
  '';

  # Matugen template: CSS colors
  home.file.".config/matugen/templates/colors.css".text = ''
    /*
    * Css Colors
    * Generated with Matugen
    */
    <* for name, value in colors *>
        @define-color {{name}} {{value.default.hex}};
    <* endfor *>
  '';

  # Matugen template: Hyprland colors
  home.file.".config/matugen/templates/hyprland-colors.conf".text = ''
    <* for name, value in colors *>
    $image = {{image}}
    ${{name}} = rgba({{value.default.hex_stripped}}ff)
    <* endfor *>
  '';
}
