{ config, pkgs, ... }:

{
  # XDG user directories, ported from .config/user-dirs.dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    # keep exporting XDG_*_DIR as session variables (pre-25.11 behavior)
    setSessionVariables = true;
    desktop = "$HOME/Desktop";
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    publicShare = "$HOME/Public";
    templates = "$HOME/Templates";
    videos = "$HOME/Videos";
  };

  # Default applications. The fedora mimeapps.list is mostly GNOME
  # auto-generated defaults; only the entries that matter are ported.
  # zen (flatpak) is the default browser, brave the fallback.
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = [ "app.zen_browser.zen.desktop" ];
      "x-scheme-handler/http" = [ "app.zen_browser.zen.desktop" ];
      "x-scheme-handler/https" = [ "app.zen_browser.zen.desktop" ];
      "application/xhtml+xml" = [ "app.zen_browser.zen.desktop" ];

      "text/plain" = [ "dev.zed.Zed.desktop" ];
      "application/json" = [ "dev.zed.Zed.desktop" ];

      "application/pdf" = [ "org.gnome.Evince.desktop" ];

      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

      "x-scheme-handler/mailto" = [ "net.thunderbird.Thunderbird.desktop" ];

      # Archives (fedora used thunar, which is not installed here)
      "application/zip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/gzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/bzip2" = [ "org.gnome.FileRoller.desktop" ];

      # Video / audio
      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "audio/mpeg" = [ "vlc.desktop" ];
    };
  };
}
