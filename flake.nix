{
  description = "Ruben's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scripts = {
      url = "github:ruben-hutter/scripts";
      flake = false;  # Not a flake, just a source repository
    };
  };

  outputs = { self, nixpkgs, home-manager, scripts, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ruben = import ./home;
            home-manager.extraSpecialArgs = { inherit scripts; };
          }
        ];
      };
    };
  };
}
