{
  stdenv,
}:
stdenv.mkDerivation {
  pname = "background";
  version = "0.1.0";
  src = "$HOME/Pictures/wallpapers";
  buildPhase = ''
    cp vadim-sherbakov-NQSWvyVRIJk-unsplash.jpg wallpaper.jpg
  '';
  installPhase = ''
    mkdir -p $out
    cp wallpaper.jpg $out/wallpaper.jpg
  '';
}
