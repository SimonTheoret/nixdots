{
  config,
  lib,
  userName,
  serverName,
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
    ../modules/cron.nix
    ../modules/devtools.nix
    ../modules/virtualization.nix
    ../modules/email.nix
    ../modules/emacs.nix
    ../modules/helix.nix
    ../modules/lab.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/nvim.nix
    ../modules/spotify.nix
    ../modules/ui.nix
    ../modules/wireless.nix
    ../hardware/${serverName}-hardware-configuration.nix
  ];
  myAudio.enable = false;
  myBluetooth.enable = false;
  myChezMoi.enable = true;
  myCommons.enable = true;
  myCron.enable = false;
  myEmacs = {
    enable = false;
  };
  myEmail.enable = false;
  myDevTools = {
    enable = true;
    kbConfigSoftware = true;
  };
  myVirtualisation.enable = true;
  myHelix = {
    enable = true;
  };
  myLight.enable = false;
  myNvidia.enable = false;
  myNeovim = {
    enable = true;
  };
  myLab = {
    enable = true;
    gitea = true;
  };
  myBootLoader.enable = true;
  myUi.enable = false;
  myWireless.enable = true;
  mySpotify = {
    enable = false;
  };
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
    ]
    ++ optionals (config.myVirtualisation.enable) [ "docker" ]
    ++ optionals (config.myAudio.enable) [ "audio" ]
    ++ optionals (config.myWireless.enable) [ "networkmanager" ];
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = false;
  environment.variables = {
    NIXOS_CONF = "${serverName}";
    IS_ON_NIX = "true";
  };
}
