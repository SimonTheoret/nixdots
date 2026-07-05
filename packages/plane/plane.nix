{
  stdenv,
}:

stdenv.mkDerivation rec {
  pname = "plane";
  src = ./.;
  version = "1.3.1";
  installPhase = ''

     runHook preInstall

     mkdir -p $out/bin
     cp  ./setup.sh $out/bin/plane
     cp ./docker-compose.yaml ./plane.env $out/
     patchShebangs --host $out/bin/plane

    substituteInPlace $out/bin/plane \
         --replace-fail "@ASSET_DIR@" "$out"

    substituteInPlace $out/bin/plane \
         --replace-fail "@VERSION@" "v${version}"

     runHook postInstall
  '';

}
