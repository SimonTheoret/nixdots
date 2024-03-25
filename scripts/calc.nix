{ pkgs ? import <nixpkgs> { } }:
let pythonpkgs = with pkgs.python311Packages; [ numpy matplotlib scipy ];
in pkgs.stdenv.mkDerivation {
  name = "calc";
  propagatedBuildInputs = [ pkgs.python311Full ] ++ pythonpkgs;
  dontUnpack = true;
  installPhase = ''
    install -Dm755 ${./calc.py} $out/bin/calc
  '';
}
