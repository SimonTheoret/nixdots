{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "lua-json5";
  version = "18d8308656f79fdaa5936b4e42bb07b4bbd2354e";

  src = fetchFromGitHub {
    owner = "Joakker";
    repo = pname;
    rev = version;
    hash = "sha256-+s5RBC3XSgb8omTbUNLywZnP6jSxZBKSS1BmXOjRF8M=";
  };


  useFetchCargoVendor = true;
  # cargoHash = "";
  cargoHash = lib.fakeHash; 

  cargoLock.lockFile = ./Cargo.lock;

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  meta = {
    description = "JSON5 for LuaJIT, written in Rust ";
    homepage = "https://github.com/Joakker/lua-json5";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
