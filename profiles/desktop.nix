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
    ../modules/email.nix
    ../modules/emacs.nix
    ../modules/gitlab.nix
    ../modules/helix.nix
    ../modules/lab.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/nvim.nix
    ../modules/spotify.nix
    ../modules/sync.nix
    ../modules/ui.nix
    ../modules/virtualization.nix
    ../modules/wireless.nix
    ../hardware/desktop-hardware-configuration.nix
  ];
  myAudio = {
    enable = true;
    guiControls = true;
    noiseCanceling = true;
  };
  myBluetooth = {
    enable = true;
    driver = true;
  };
  myChezMoi.enable = true;
  myCleanup.enable = true;
  myCommons = {
    enable = true;
    firefoxResize = "1.0";
  };
  myCron.enable = false;
  myEmacs = {
    enable = false;
  };
  myEmail = {
    enable = false;
    gui = false;
  };
  myGitlab = {
    enable = false;
  };
  myDevTools = {
    enable = true;
    useLLM = false;
    kbConfigSoftware = true;
    drawingTools = true;
  };
  myVirtualisation.enable = true;
  myHelix = {
    enable = true;
  };
  myLight.enable = false; # false by default
  myLab = {
    enable = true;
    plane = true;
    searxng = true;
  };
  myNvidia.enable = true;
  myNeovim = {
    enable = true;
  };
  myUi = {
    enable = true;
    monitorsConfig = false;
    useGUI = true;
    hyprland = false;
    i3WM = false;
    niri = true;
  };
  myWireless.enable = false;
  mySpotify = {
    enable = true;
  };
  mySync.enable = false;
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
  nixpkgs.config.cudaSupport = true;
  environment.variables = {
    NIXOS_CONF = "desktop";
    IS_ON_NIX = "true";
  }
  // optionals (config.myNvidia.enable) {
    GSK_RENDERER = "ngl";
  };
}
