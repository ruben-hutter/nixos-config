{ config, pkgs, ... }:

{
  # GPG for signed commits (keys are imported manually on a new machine:
  # gpg --import). Signing key is set in git.nix.
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    pinentry.package = pkgs.pinentry-gnome3;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
  };
}
