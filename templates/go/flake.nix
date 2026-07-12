{
  description = "A Nix-flake-based Go 1.xx development environment";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            go_1_26
          ];
          inputsFrom = with pkgs; [
            golangci-lint
            gotools
            gopls
            gdb
            just
          ];
        };
      }
    );
}
