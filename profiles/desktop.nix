{
  config,
  lib,
  userName,
  ...
}:
let
  inherit userName;
  inherit (lib) optionals;
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
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/nvim.nix
    ../modules/ui.nix
    ../modules/wireless.nix
    ../hardware/desktop-hardware-configuration.nix
  ];
  myAudio.enable = true;
  myAudio.guiControls = true;
  myBluetooth.enable = true;
  myChezMoi.enable = true;
  myCommons.enable = true;
  myEmacs = {
    enable = false;
  };
  myEmail = {
    enable = true;
    guiOnly = true;
  };
  myDevTools.enable = true;
  myDocker.enable = true;
  myLight.enable = false; # false by default
  myNvidia.enable = true;
  myNeovim = {
    enable = true;
    mainEditor = true;
  };
  myUi = {
    enable = true;
    monitorsConfig = true;
    useGUI = true;
  };
  myWireless.enable = false;
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups =
      [
        "wheel"
        "video"
      ]
      ++ optionals (config.myDocker.enable) [ "docker" ]
      ++ optionals (config.myAudio.enable) [ "audio" ];
  };
  environment.variables = {
    NIXOS_CONF = "desktop";
    IS_ON_NIX = "true";
  };
}
