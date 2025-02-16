{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        inherit (self) outputs;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            userName = "simon";
          };
          modules = [
            ./profiles/desktop.nix
          ];
        };

        nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            userName = "simon";
          };
          modules = [
            ./profiles/laptop.nix
          ];
        };

        devShells.default = pkgs.mkShell {
          name = "Nixdots Shell";
          buildInputs = with pkgs; [ ];
        };
      }
    );
}
