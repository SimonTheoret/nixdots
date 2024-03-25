# Timer.nix.
# Building the timer application, a simple pomodoro gui app written in Rust.
{ lib, stdenv, fetchFromGitHub, rustc, cargo, rustPlatform, git, cmake, libgcc
, xorg, pkg-config, libGL, libxkbcommon, makeWrapper, autoPatchelfHook }:

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

  nativeBuildInputs = [
    cargo
    rustc
    git
    cmake
    libgcc
    xorg.libX11
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor
    pkg-config
    libxkbcommon
    libGL
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    pkg-config
    cargo
    rustc
    git
    cmake
    libgcc
    xorg.libX11
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor
    pkg-config
    libxkbcommon
    libGL
  ];

  postFixup = ''
    wrapProgram $out/bin/timer_rust \
      --set LD_LIBRARY_PATH ${
        lib.makeLibraryPath [
          xorg.libX11
          xorg.libXi
          xorg.libXrandr
          xorg.libXcursor
          libxkbcommon
          libGL
        ]
      }
  '';
}
