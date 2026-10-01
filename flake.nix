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
          # --no-root-passwd: skip nixos-install's root prompt (it would run
          # right after the long build phase); root gets ruben's hash below
          # on request instead.
          nixos-install --no-root-passwd --flake "${self}#''${host}"
          echo
          echo "Setting the password for 'ruben'."
          nixos-enter --root /mnt -c "passwd ruben"
          read -r -p "Use the same password for root? [y/N] " answer
          case "''${answer}" in
            y|Y|yes|Yes)
              # copy ruben's fresh sha-512 hash instead of asking twice
              hash="$(nixos-enter --root /mnt -c "grep '^ruben:' /etc/shadow | cut -d: -f2")"
              nixos-enter --root /mnt -c "echo 'root:''${hash}' | chpasswd -e"
              echo "root: password set (same as ruben)."
              ;;
            *)
              echo "root: left locked (no password login; ssh key access still works if declared)."
              ;;
          esac
          echo "Done. You can reboot now."
        ''}";
      };
    };
}
