{ config, pkgs, ... }:

{
  # Haskell toolchain, nix-native. This replaces ghcup: nixpkgs'
  # haskell-language-server is built against the same GHC as pkgs.ghc, so
  # the HLS/GHC ABI problem from fedora (ghcup HLS vs mason HLS) cannot
  # happen here. Per-project GHC versions belong in a nix devShell
  # (direnv), not in the global profile.
  home.packages = with pkgs; [
    ghc                     # ghc + ghci
    cabal-install           # cabal
    haskell-language-server # matches the ghc above
  ];
}
