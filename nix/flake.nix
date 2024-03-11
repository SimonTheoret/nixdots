{
  description = "Nixos config flake";

  nixConfig = {
    substituers =
      [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, ... }@inputs:
    # once the inputs are resolved, they're passed to the function `outputs` along
    # with with `self`, which is the directory of this flake in the store.

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixosDesktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixfiles/configuration.nix

          { nix.settings.trusted-users = [ "simon" ]; }
          ./profiles/desktop.nix
        ];
      };
      nixosConfigurations.nixoslaptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixfiles/configuration.nix

          { nix.settings.trusted-users = [ "simon" ]; }
          ./profiles/laptop.nix
        ];
      };

    };
}
