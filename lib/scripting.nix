{ pkgs, stdenv, ... }: {
  # Similar to writeShellScript and writeScriptBin.
  # Writes an executable Shell script to /nix/store/<store path>/bin/<name> and checks its syntax.
  # Automatically includes interpreter above the contents passed.
  #
  # Example:
  # # Writes my-file to /nix/store/<store path>/bin/my-file and makes executable.
  # writeShellScriptBin "my-file"
  #   ''
  #   Contents of File
  #   '';
  #
  writeShellScriptBinBang = name: text: shellstring:
    pkgs.writeTextFile {
      inherit name;
      executable = true;
      destination = "/bin/${name}";
      text = ''
        #!${shellstring}
        ${text}
      '';
      checkPhase = ''
        ${stdenv.shell} -n $out/bin/${name}
      '';
    };
}
