{
  config,
  lib,
  userName,
  ...
}@inputs:
let
  inherit userName;
  inherit (lib) mkOption mkIf optionals;
in
{
  imports = [
    ../modules/audio.nix
    ../modules/bluetooth.nix
    ../modules/chezmoi.nix
    ../modules/commons.nix
    ../modules/devtools.nix
    ../modules/docker.nix
    ../modules/email.nix
    ../modules/emacs.nix
    ../modules/helix.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/nvim.nix
    ../modules/ui.nix
    ../modules/wireless.nix
    ../hardware/server-hardware-configuration.nix
  ];
  myAudio = {
    enable = false;
    guiControls = false;
    noiseCanceling = false;
  };
  myBluetooth.enable = true;
  myChezMoi.enable = true;
  myCommons.enable = true;
  myEmacs = {
    enable = false;
  };
  myEmail.enable = false;
  myDevTools.enable = true;
  myDocker.enable = true;
  myHelix= {
    enable = true;
  };
  myLight.enable = false; # false by default
  myNvidia.enable = false;
  myNeovim = {
    enable = true;
  };
  myBootLoader.enable = false; # true by default
  myUi = {
    enable = false;
    monitorsConfig = false; # My server has a single screen
    useGUI = false;
    hyprland = false;
    i3WM = false;
  };
  myWireless.enable = true;
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups =
      [
        "wheel"
        "video"
      ]
      ++ optionals (config.myDocker.enable) [ "docker" ]
      ++ optionals (config.myAudio.enable) [ "audio" ]
      ++ optionals (config.myWireless.enable) [ "networkmanager" ];
  };
  environment.variables = {
    NIXOS_CONF = "server";
    IS_ON_NIX = "true";
  };
}
