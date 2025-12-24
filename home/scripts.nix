{ config, pkgs, lib, ... }:

let
  # Automatically find all files in the scripts directory
  scriptsDir = ./scripts;
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
