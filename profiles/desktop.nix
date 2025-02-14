{config, lib, userName, ...}@inputs:
let 
inherit (lib) mkOption mkIf;
inherit userName;
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
    ../modules/hardware-configuration.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/ui.nix
  ];

  myAudio.enable = true;
  myAudio.guiControls = true;
  myBluetooth.enable = true;
  myChezMoi.enable = true;
  myCommons.enable = true;
  myEmail.enable = true;
  myDevTools.enable = true;
  myDocker.enable = true;
  myLight.enable = false; # false by default
  myNvidia.enable = true; 
  myUi = {
    enable = true;
    monitorsConfig = true;
    useGUI = true;
  }; 
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" "video" "audio"];
  };
};
