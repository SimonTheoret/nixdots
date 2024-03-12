{ pkgs, stdenv, ... }: rec {
  # Similar to writeShellScript and writeScriptBin.
  # Writes an executable Shell script to /nix/store/<store path>/bin/<name> and checks its syntax.
  # Automatically includes interpreter with the shellstring argument above the contents passed.
  #
  # Example:
  # # Writes my-file to /nix/store/<store path>/bin/my-file and makes executable with bash shebang.
  # writeShellScriptBin "my-file" pkgs.${python}
  #   ''
  #   Contents of File
  #   '';
  #
  writeShellScriptBinBang = name: shellstring: text:
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

  writeShellScriptNix = name: text:
    writeShellScriptBinBang { shellstring = "/usr/bin/env nix-shell"; };
}
