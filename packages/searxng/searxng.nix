{
  lib,
  writeShellApplication,
  docker,
  docker-compose,
  bash,
  searxngVersion ? "latest",
  searxngPort ? "8080",
  searxngAddress ? null,
}:

let
  fs = lib.fileset;
  dockerComposeFile = fs.toSource {
    root = ./.;
    fileset = ./docker-compose.yml;
  };
in

writeShellApplication {
  name = "searxng";
  text = builtins.replaceStrings [ "@DOCKER@" ] [ "${dockerComposeFile}/docker-compose.yml" ] (
    builtins.readFile ./searxng.sh
  );
  runtimeEnv = {
    SEARXNG_VERSION = "${searxngVersion}";
    SEARXNG_PORT = "${searxngPort}";
  }
  // lib.attrsets.optionalAttrs (searxngAddress != null) {
    SEARXNG_HOST = "${searxngAddress}";
  };
  runtimeInputs = [
    docker
    bash
    docker-compose
  ];
  excludeShellChecks = [ ];
}
