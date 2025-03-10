{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myAudio;
in
{
  imports = [];

  options.myAudio = {
    guiControls = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Use pavucontrol in a GUI to control audio. This option is set automatically if `config.myUi.useGUI=true`" ;
    };
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Activate and configure audio.";
    };

    noiseCanceling = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Activate and configure noise canceling with NoiseTorch.";
    };
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    myAudio.guiControls = config.myUi.useGUI; # Used by default pavucontrol in a GUI environment

    services.playerctld.enable = true;

    progams.noisetorch.enable = cfg.noiseCanceling && cfg.enable;

    environment.systemPackages = with pkgs; [pamixer] ++ pkgs.lib.optionals (cfg.guiControls) [pavucontrol];
  };
}

