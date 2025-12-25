{ config, pkgs, lib, scripts, ... }:

let
  # Scripts from flake input (github:ruben-hutter/scripts)
  scriptsDir = scripts;
  # Automatically find all files in the scripts directory
  scriptFiles = builtins.attrNames (builtins.readDir scriptsDir);
in
{
  # Install all scripts from home/scripts/ to ~/scripts/
  # Automatically makes them executable
  home.file = builtins.listToAttrs (
    map (script: {
      name = "scripts/${script}";
      value = {
        source = scriptsDir + "/${script}";
        executable = true;
      };
    }) scriptFiles
  );
}
