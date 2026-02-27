{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myAudio;
in
{
  imports = [ ];

  options.myAudio = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Activate and configure audio.";
    };
  };

  config = mkIf cfg.enable {
    services.gitlab.enable = true;
    environment.systemPackages = with pkgs; [ ];
  };
}
