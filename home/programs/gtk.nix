{ config, pkgs, lib, ... }:

{
  # GTK theming, ported from the fedora nwg-look-generated settings:
  # adw-gtk3-dark theme, Papirus-Dark icons, Adwaita Sans font.
  # Cursor theme comes from home.pointerCursor (default.nix).
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Adwaita Sans";
      size = 11;
    };

    gtk3.extraConfig = {
      gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 1;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 0;
    };

    gtk2 = {
      configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
      extraConfig = ''
        gtk-toolbar-style=GTK_TOOLBAR_ICONS
        gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
        gtk-button-images=0
        gtk-menu-images=0
        gtk-enable-event-sounds=1
        gtk-enable-input-feedback-sounds=0
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };
  };

  # User GTK CSS tweaks (window rounding etc.), ported verbatim.
  # The dank-colors.css files are DMS/matugen-generated: seeded on first
  # login, owned by DMS afterwards (same pattern as niri dms/*.kdl).
  gtk.gtk3.extraCss = builtins.readFile ./assets/gtk3/gtk.css;
  gtk.gtk4.extraCss = builtins.readFile ./assets/gtk4/gtk.css;

  home.activation.gtkDankColorsSeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for pair in "gtk-3.0 ${./assets/gtk3/dank-colors.css}" "gtk-4.0 ${./assets/gtk4/dank-colors.css}"; do
      set -- $pair
      dir="$HOME/.config/$1"
      src="$2"
      if [ ! -f "$dir/dank-colors.css" ]; then
        $DRY_RUN_CMD mkdir -p "$dir"
        $DRY_RUN_CMD install -m 644 "$src" "$dir/dank-colors.css"
      fi
    done
  '';
}
