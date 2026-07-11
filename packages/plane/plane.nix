{
  writeShellApplication,
  docker,
  bash,
  docker-compose,
  lib,
  version ? "1.3.1",
}:

let
  fs = lib.fileset;
  assets = fs.toSource {
    root = ./.;
    fileset = fs.unions [
      ./docker-compose.yaml
      ./plane.env
    ];
  };
in

writeShellApplication {
  name = "plane";
  text = builtins.replaceStrings [ "@VERSION@" "@ASSET_DIR@" ] [ "v${version}" "${assets}" ] (
    builtins.readFile ./setup.sh
  );
  runtimeInputs = [
    docker
    bash
    docker-compose
  ];
  # The initial script is garbage.
  excludeShellChecks = [
    "SC2162"
    "SC2155"
    "SC2115"
    "SC2164"
    "SC2103"
    "SC2086"
    "SC1090"
    "SC1107"
    "SC2148"
    "SC2181"
    "SC2034"
  ];
}
