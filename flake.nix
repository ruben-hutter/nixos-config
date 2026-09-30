{
  description = "Ruben's NixOS configuration";

  inputs = {
    # nixos-unstable as the daily-driver base. Required because
    # DankMaterialShell needs go >= 1.26 and quickshell >= 0.3, which the
    # stable release lags behind on. Unstable is a rolling channel with
    # basic QA and is widely used as a daily driver.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scripts = {
      url = "github:ruben-hutter/scripts";
      flake = false;
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, scripts, dms, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # Shared wiring for all hosts. Everything host-specific lives in the
      # host's own directory: hardware.nix (generated), disko.nix (disk
      # layout), guest.nix (VM-only), plus host tweaks.
      # Adding a host: hosts/<name>/ + one line below.
      mkNixosSystem = hostModule: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          hostModule

          # Declarative disk partitioning
          disko.nixosModules.default

          # Official DankMaterialShell system module (service, quickshell, polkit)
          dms.nixosModules.dank-material-shell

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ruben = import ./home;
            home-manager.extraSpecialArgs = { inherit scripts; };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        nixos = mkNixosSystem ./hosts/nixos;
        # future: laptop = mkNixosSystem ./hosts/laptop;
      };

      # Shortcuts:
      #   sudo nix run .#disko      partition + mount only
      #   sudo nix run .#bootstrap  erase disk, partition, install from this flake
      packages.x86_64-linux.diskoScript = self.nixosConfigurations.nixos.config.system.build.diskoScript;
      apps.x86_64-linux.disko = {
        type = "app";
        program = "${self.nixosConfigurations.nixos.config.system.build.diskoScript}";
      };
      apps.x86_64-linux.bootstrap = {
        type = "app";
        program = "${pkgs.writeShellScript "bootstrap-nixos" ''
          set -euo pipefail
          host="nixos"
          echo "This will ERASE the disk declared in hosts/''${host}/disko.nix"
          echo "and install NixOS from this flake."
          read -r -p "Type 'erase' to continue: " answer
          [ "''${answer}" = "erase" ] || { echo "Aborted."; exit 1; }
          ${self.nixosConfigurations.nixos.config.system.build.diskoScript}
          nixos-install --flake "${self}#''${host}"
          # set the user's password too (nixos-install only asks for root)
          nixos-enter --root /mnt -c "passwd ruben"
        ''}";
      };
    };
}
