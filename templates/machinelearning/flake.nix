{
  description = "Python 3.XX development environment for Machine Learning";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:
    let
      pyVersion = 311;
      overlays = [
        (final: prev: {
          # Makes it easier to change python version, and its related packages.
          python = prev."python${toString pyVersion}Full";
          pythonPackages = prev."python${toString pyVersion}Packages";
        })
      ];
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs {
              inherit overlays system;
              config.allowUnfree = true;
              config.cudaSupport = true;
            };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              cudaPackages.cudatoolkit
              linuxPackages.nvidia_x11
              cudaPackages.cudnn
              libGLU
              libGL
              xorg.libXi
              xorg.libXmu
              freeglut
              xorg.libXext
              xorg.libX11
              xorg.libXv
              xorg.libXrandr
              zlib
              ncurses5
              stdenv.cc
              binutils
              python
              pythonPackages.pip
              pythonPackages.virtualenv
              nodePackages_latest.pyright
              ruff
              ruff-lsp
              nodePackages_latest.bash-language-server
              shellcheck
              shfmt
              isort
              nixfmt-classic
              nil
            ];

            shellHook = ''
              export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib"
            '';
          };
        }
      );
    };
}
