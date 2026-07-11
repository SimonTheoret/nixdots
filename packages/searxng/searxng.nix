{
  stdenv,
  version ? "latest",
  host ? "localhost",
  port ? "8080",
}:

stdenv.mkDerivation {
  pname = "searxng";
  src = ./.;
  version = "${version}";
  installPhase = ''

    runHook preInstall

    mkdir -p $out/bin
    cp  ./searxng $out/bin/searxng
    cp ./docker-compose.yaml $out/

    echo "SEARXNG_VERSION=${version}>>.env"
    echo "SEARXNG_PORT=${port}>>.env"
    echo "SEARXNG_HOST=${host}>>.env"

    patchShebangs --host $out/bin/searxng

    runHook postInstall
  '';

}
