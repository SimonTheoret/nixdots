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
    ../modules/helix.nix
    ../modules/lab.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/nvim.nix
    ../modules/spotify.nix
    ../modules/ui.nix
    ../modules/virtualization.nix
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
  myCommons = {
    enable = true;
    firefoxResize = "1.25";
    enableSyncthing = false;
  };
  myCron.enable = false;
  myDevTools = {
    enable = true;
    kbConfigSoftware = false;
    drawingTools = true;
  };
  myVirtualisation.enable = true;
  myEmacs = {
    enable = true;
  };
  myEmail = {
    enable = false;
    gui = false;
  };
  myHelix = {
    enable = true;
  };
  myLight.enable = true; # false by default
  myLab = {
    enable = true;
    plane = false;
    searxng = false;
    appflowy = false;
    tailscale = true;
  };
  myNvidia.enable = false;
  myNeovim = {
    enable = true;
  };
  myUi = {
    enable = true;
    monitorsConfig = false; # My laptop has a single screen
    useGUI = true;
    hyprland = false;
    niri = true;
    cosmic = false;
    i3WM = false;
  };
  myWireless.enable = true;
  mySpotify = {
    enable = false;
  };
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "dialout"
    ]
    ++ optionals (config.myVirtualisation.enable) [ "docker" ]
    ++ optionals (config.myAudio.enable) [ "audio" ]
    ++ optionals (config.myWireless.enable) [ "networkmanager" ];
  };
  hardware.system76.enableAll = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = false;
  environment.variables = {
    NIXOS_CONF = "laptop";
    IS_ON_NIX = "true";
  };
}
