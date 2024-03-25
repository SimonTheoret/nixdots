{ pkgs ? import <nixpkgs> { } }:
let pythonpkgs = with pkgs.python311Packages; [ numpy matplotlib scipy ];
in pkgs.stdenv.mkDerivation {
  name = "calc";
  propagatedBuildInputs = [ pkgs.python311Full ] ++ pythonpkgs;
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 ${./calc.py} $out/bin
    echo "$out/bin"
  '';
}
