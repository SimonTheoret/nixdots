# default.nix
let
  nixpkgs =
    fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixpkgs-stable";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in { timer = pkgs.callPackage ./timer.nix { }; }
