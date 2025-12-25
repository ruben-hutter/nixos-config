{ config, pkgs, lib, ... }:

{
  home.file.".config/niri/config.kdl".text = ''
    // Niri configuration
    // https://github.com/YaLTeR/niri

    // Environment variables
    environment {
        XDG_CURRENT_DESKTOP "niri"
        QT_QPA_PLATFORM "wayland"
        QT_QPA_PLATFORMTHEME "qt6ct"
        QT_QPA_PLATFORMTHEME_QT6 "qt6ct"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        XCURSOR_THEME "Bibata-Modern-Ice"
        XCURSOR_SIZE "22"
    }

    // Autostart applications
    spawn-at-startup "${pkgs.tmux}/bin/tmux" "new-session" "-d"

    // Prefer no client-side decorations
    prefer-no-csd

    // Global window rules
    window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
        tiled-state true
        draw-border-with-background false
    }

    window-rule {
        match is-active=false
        opacity 0.9
    }

    // Specific window rules
    window-rule {
        match app-id="lxqt-policykit-agent"
        open-floating true
        default-column-width { fixed 400; }
        default-window-height { fixed 200; }
    }

    window-rule {
        match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
        default-floating-position x=10 y=10 relative-to="bottom-right"
    }

    // Overview settings
    overview {
        zoom 0.4
        workspace-shadow {
            off
        }
    }

    // Hotkey overlay
    hotkey-overlay {
        skip-at-startup
        hide-not-bound
    }

    // Gestures
    gestures {
        dnd-edge-view-scroll {
            trigger-width 30
            delay-ms 100
            max-speed 1500
        }

        dnd-edge-workspace-switch {
            trigger-height 50
            delay-ms 100
            max-speed 1500
        }

        hot-corners {
            off
        }
    }

    // Screenshot path
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // Input configuration
    input {
        keyboard {
            xkb {
                layout "ch"
                variant "fr"
            }
            numlock
        }

        touchpad {
            tap
            natural-scroll
        }

        mouse {
        }

        touch {
            map-to-output "eDP-1"
        }

        warp-mouse-to-focus
        focus-follows-mouse max-scroll-amount="10%"

        mod-key "Super"
        mod-key-nested "Alt"
    }

    // Output configuration
    output "BOE 0x0CE0 Unknown" {
        scale 1.0
        position x=0 y=0
    }

    output "HP Inc. HP 24fh 3CM0330VYC   " {
        focus-at-startup
        scale 1.0
        position x=1920 y=0
    }

    output "HP Inc. HP 24fh 3CM033045N   " {
        scale 1.0
        position x=3840 y=0
    }

    output "HP Inc. HP E34m G4 CNC4140Q0S" {
        focus-at-startup
        scale 1.1

        layout {
            default-column-width { proportion 0.33333; }

            preset-column-widths {
                proportion 0.33333
                proportion 0.5
                proportion 0.66667
            }
        }
    }

    // Layout configuration
    layout {
        gaps 16
        center-focused-column "never"
        always-center-single-column

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        // Focus ring
        focus-ring {
            width 2
            active-color "#a5c8fe"
            inactive-color "#8d9199"
        }

        // Border
        border {
            width 4
            active-color "#a5c8fe"
            inactive-color "#8d9199"
            urgent-color "#ffb4ab"
        }

        // Shadows (disabled by default)
        shadow {
            softness 30
            spread 5
            offset x=0 y=5
            color "#00000070"
        }

        struts {
        }

        background-color "transparent"
    }

    // Animations
    animations {
    }

    // Keybindings
    binds {
        Mod+Shift+Q { show-hotkey-overlay; }

        Mod+Return hotkey-overlay-title="Open a Terminal: alacritty" {
            spawn "${pkgs.alacritty}/bin/alacritty";
        }
        Mod+Shift+Return hotkey-overlay-title="Open a File Manager: nautilus" {
            spawn "${pkgs.gnome-file-manager}/bin/nautilus";
        }
        Mod+G hotkey-overlay-title="Toggle Gaming Mode (start/stop kanata)" {
            spawn-sh "$HOME/scripts/toggle-gaming-mode.sh";
        }

        XF86AudioRaiseVolume allow-when-locked=true {
            spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
        }
        XF86AudioLowerVolume allow-when-locked=true {
            spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
        }
        XF86AudioMute allow-when-locked=true {
            spawn "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        }
        XF86AudioMicMute allow-when-locked=true {
            spawn "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        }

        XF86MonBrightnessUp allow-when-locked=true {
            spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "10%+";
        }
        XF86MonBrightnessDown allow-when-locked=true {
            spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "10%-";
        }

        Mod+O repeat=false { toggle-overview; }
        Mod+MouseBack repeat=false { toggle-overview; }

        Mod+Q repeat=false { close-window; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Ctrl+Left  { focus-monitor-left; }
        Mod+Ctrl+Down  { focus-monitor-down; }
        Mod+Ctrl+Up    { focus-monitor-up; }
        Mod+Ctrl+Right { focus-monitor-right; }
        Mod+Ctrl+H     { focus-monitor-left; }
        Mod+Ctrl+J     { focus-monitor-down; }
        Mod+Ctrl+K     { focus-monitor-up; }
        Mod+Ctrl+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        Mod+Tab { focus-workspace-previous; }

        Mod+Comma  { consume-or-expel-window-left; }
        Mod+Period { consume-or-expel-window-right; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+C { center-column; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+T       { toggle-window-floating; }
        Mod+Shift+T { switch-focus-between-floating-and-tiling; }

        Mod+W { toggle-column-tabbed-display; }

        Print { screenshot show-pointer=false; }
        Ctrl+Print { screenshot-screen; }
        Shift+Print { screenshot-window; }
        Mod+S { screenshot show-pointer=false; }
        Mod+Ctrl+S { screenshot-screen; }
        Mod+Shift+S { screenshot-window; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+Shift+E { quit; }

        Mod+Shift+P { power-off-monitors; }

        Mod+Shift+Ctrl+T { toggle-debug-tint; }
    }
  '';
}
