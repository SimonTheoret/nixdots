{
  description = "Python 3.XX development environment for Machine Learning";
  outputs = { self, nixpkgs }:
    let
      pyVersion = "11";
      overlays = [
        (final: prev: { # Makes it easier to change python version, and its related packages.
          python = prev."python${toString pyVersion}Full";
          pythonPackages = prev."python${toString pyVersion}Packages";
        })
      ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.cudaSupport = true;
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          cudatoolkit
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
          # pythonPackages.numpy
          # pythonPackages.pytorch-bin
          pythonPackages.virtualenv
        ];

        shellHook = ''
          export LD_LIBRARY_PATH="${pkgs.linuxPackages.nvidia_x11}/lib"
        '';
      };
    };
}
