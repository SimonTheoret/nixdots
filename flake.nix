{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          userName = "simon";
          pkgsUnstable = import nixpkgs-unstable {
            system = "x86_64-linux";
          };
        };
        modules = [
          ./profiles/desktop.nix
        ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          userName = "simon";
          pkgsUnstable = import nixpkgs-unstable {
            system = "x86_64-linux";
          };
        };
        modules = [
          ./profiles/laptop.nix
        ];
      };

      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          userName = "simon";
          pkgsUnstable = import nixpkgs-unstable {
            system = "aarch64-linux";
          };
        };
        modules = [
          ./profiles/server.nix
        ];
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell { };
        }
      );
    };
}
