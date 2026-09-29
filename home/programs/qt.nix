{ config, pkgs, ... }:

{
  # Qt apps themed via qt6ct (fedora setup); DMS's matugen templates
  # regenerate the qt5ct/qt6ct color configs at runtime.
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };
}
