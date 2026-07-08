{
  stdenv,
}:
let
  filename = "wallpaper.jpg";
in
stdenv.mkDerivation {
  name = "wallpaper";
  src = ./.;
  installPhase = ''

    runHook preInstall
    mkdir -p $out
    cp -v ${filename} $out/wallpaper.jpg
    runHook postInstall

  '';
}
