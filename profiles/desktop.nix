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
    ../modules/helix.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/nvim.nix
    ../modules/ui.nix
    ../modules/wireless.nix
    ../hardware/desktop-hardware-configuration.nix
  ];
  myAudio = {
    enable = true;
    guiControls = true;
    noiseCanceling = true;
  };
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
  myHelix= {
    enable = true;
  };
  myLight.enable = false; # false by default
  myNvidia.enable = true;
  myNeovim = {
    enable = true;
  };
  myUi = {
    enable = true;
    monitorsConfig = false; # No need for it when using hyprland
    useGUI = true;
    hyprland = true;
    i3WM = false;
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
      ++ optionals (config.myAudio.enable) [ "audio" ]
      ++ optionals (config.myWireless.enable) [ "networkmanager" ];
  };
  environment.variables = {
    NIXOS_CONF = "desktop";
    IS_ON_NIX = "true";
  };
}
