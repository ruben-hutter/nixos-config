{ config, pkgs, lib, ... }:

let
  # blink1-tiny-server: tiny HTTP server for the blink(1) USB status light.
  # Part of the C blink1-tool repo (server/blink1-tiny-server.c); only the
  # CLI tool is packaged in nixpkgs, so we build the server from source.
  # Pinned to the same revision as the ~/src/blink1-tool checkout on the
  # fedora machine (v2.5.0-33-g668e184).
  blink1-tiny-server = pkgs.stdenv.mkDerivation {
    pname = "blink1-tiny-server";
    version = "2.5.0";

    src = pkgs.fetchFromGitHub {
      owner = "todbot";
      repo = "blink1-tool";
      rev = "668e184807ed878fcf900628029e252070ec470c";
      hash = "sha256-DuQjgBvHAwkbLddnou8lSd+fen561oOJ+jXPFaaWMJM=";
    };

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.libusb1 ];

    # The repo vendors hidapi and builds with plain make
    buildPhase = ''
      runHook preBuild
      make blink1-tiny-server
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      install -Dm755 blink1-tiny-server "$out/bin/blink1-tiny-server"
      runHook postInstall
    '';

    meta.mainProgram = "blink1-tiny-server";
  };
in
{
  # blink(1) status light HTTP server on 127.0.0.1:8934, used by pi for
  # notifications (user service mirrors the fedora unit; the udev rule is
  # in modules/services/blink1.nix)
  systemd.user.services.blink1-tiny-server = {
    Unit = {
      Description = "blink(1) tiny HTTP server";
      After = [ "local-fs.target" ];
    };

    Service = {
      ExecStart = "${blink1-tiny-server}/bin/blink1-tiny-server --host 127.0.0.1 --port 8934";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
