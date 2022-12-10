{
  description = "Jeon's Personal NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
       tp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
         home-manager.nixosModules.home-manager
         ./hw/default.nix
         ./hw/tp/default.nix
         ./sw/default.nix
        ];
      };
       vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
         home-manager.nixosModules.home-manager
         ./hw/default.nix
         ./hw/vm/default.nix
         ./sw/default.nix
        ];
      };
     };
  };
}
