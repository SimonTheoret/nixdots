{
  description = "A Nix-flake-based Python development environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      pyVersion = 311; # version without any dot
      overlays = [
        (final: prev: { # Makes it easier to change python version, and its related packages.
          python = prev."python${toString pyVersion}Full";
          pythonPackages = prev."python${toString pyVersion}Packages";
        })
      ];
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system:
          f {
            pkgs = import nixpkgs {
              inherit system overlays;
              config = {
                allowUnfree = true;
                cudaSupport = true;
              };
            };
          });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs;
            [
              python
              nodePackages_latest.pyright
              ruff
              ruff-lsp
              isort

            ] ++ (with pkgs.pythonPackages; [ pip virtualenv ]);
        };
      });
    };
}
