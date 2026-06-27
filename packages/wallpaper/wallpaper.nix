{
  stdenv,
  fetchgit,
}:
let
  filename = "vadim-sherbakov-NQSWvyVRIJk-unsplash.jpg";
  path = "Pictures/wallpapers/${filename}";
in
stdenv.mkDerivation {
  name = "wallpaper";
  src = fetchgit {
    url = "https://github.com/simontheoret/chezmoi";
    sparseCheckout = [ "${path}" ];
    hash = "sha256-lN68Xi/MyuQtTyya3E+fyG2tkGznrG8s8Q87ayFVg9k";
  };
  postInstall = ''
    mkdir $out
    ls
    cp -v ${path} $out/wallpaper.jpg
  '';
}
