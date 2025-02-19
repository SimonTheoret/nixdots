{
  description = "Hell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        devShells.default =
          (pkgs.buildFHSUserEnv {
            name = "fhs-shell";
            targetPkgs =
              pkgs:
              (
                with pkgs;
                [
                  python313Full
                  pyright
                  ruff
                  ruff-lsp
                  isort
                ]
                ++ (with pkgs.python313Packages; [
                  pip
                  virtualenv
                ])
              );
          }).env;
      }
    );
}
