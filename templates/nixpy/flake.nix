{
  description =
    "Python 3.XX development environment for Machine Learning. Does not include ";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      pyVersion = 311;
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
              inherit overlays system;
              config.allowUnfree = true;
              config.cudaSupport = true;
            };
          });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [ python pythonPackages.pip stdenv.cc.cc.lib ];

          shellHook = ''
            # Add the library path for libstdc++.so.6
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${stdenv.cc.cc.lib}/lib"
            source .env/bin/activate
          '';
        };
      });
    };
}
