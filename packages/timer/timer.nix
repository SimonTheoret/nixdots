# Timer.nix.
# Building the timer application, a simple pomodoro gui app written in Rust.
{ lib, stdenv, fetchFromGitHub, rustc, cargo, rustPlatform, git, cmake, libgcc}:

rustPlatform.buildRustPackage rec {
  pname = "timer";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "SimonTheoret";
    repo = "timer";
    rev = "1.0.3";
    hash = "sha256-ot3mIXiIcyWZ+4ShyTWee8pu8PMoTyGnN1F/iKAvkhg=";
  };

  cargoHash = "sha256-rl44TKQ2AjMBSlGLdNoDikXJAPjA20J3Xeo2HAqSvVg=";

  nativeBuildInputs = [cargo rustc git cmake libgcc];

#   installPhase = ''
#     ls
#     ls ./target/release
#     mkdir -p $out/bin
#     cp target/release/timer_rust $out/bin
#     mv $out/bin/timer_rust $out/bin/timer
# '';
}
