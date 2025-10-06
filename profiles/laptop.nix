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
    ../modules/cron.nix
    ../modules/devtools.nix
    ../modules/docker.nix
    ../modules/email.nix
    ../modules/emacs.nix
    ../modules/helix.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/nvim.nix
    ../modules/sync.nix
    ../modules/ui.nix
    ../modules/wireless.nix
    ../hardware/laptop-hardware-configuration.nix
  ];
  myAudio = {
    enable = true;
    guiControls = true;
    noiseCanceling = true;
  };
  myBluetooth.enable = true;
  myChezMoi.enable = true;
  myCommons.enable = true;
  myCron.enable = true;
  myEmacs = {
    enable = false;
  };
  myEmail = {
    enable = true;
    gui = true;
  };
  myDevTools = {
    enable = true;
    useLLM = true;
  };
  myDocker.enable = true;
  myHelix = {
    enable = true;
  };
  myLight.enable = true; # false by default
  myNvidia.enable = false;
  myNeovim = {
    enable = true;
  };
  myUi = {
    enable = true;
    monitorsConfig = false; # My laptop has a single screen
    useGUI = true;
    hyprland = true;
    i3WM = false;
  };
  myWireless.enable = true;
  mySync.enable = false;
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "dialout"
    ]
    ++ optionals (config.myDocker.enable) [ "docker" ]
    ++ optionals (config.myAudio.enable) [ "audio" ]
    ++ optionals (config.myWireless.enable) [ "networkmanager" ];
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = false;
  environment.variables = {
    NIXOS_CONF = "laptop";
    IS_ON_NIX = "true";
  };
}
