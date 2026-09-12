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
    ../hardware/desktop-hardware-configuration.nix
  ];
  myAudio = {
    enable = true;
    guiControls = true;
    noiseCanceling = true;
  };
  myBluetooth = {
    enable = true;
  };
  myChezMoi.enable = true;
  myCommons = {
    enable = true;
    firefoxResize = "1.0";
    enableSyncthing = false;
  };
  myCron.enable = false;
  myEmacs = {
    enable = true;
  };
  myEmail = {
    enable = false;
    gui = false;
  };

  myDevTools = {
    enable = true;
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
    plane = false;
    searxng = false;
    appflowy = false;
    tailscale = true;
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
  nixpkgs.config.cudaSupport = true;
  environment.variables = {
    NIXOS_CONF = "desktop";
    IS_ON_NIX = "true";
  }
  // lib.attrsets.optionalAttrs (config.myNvidia.enable) {
    GSK_RENDERER = "ngl";
  };
}
