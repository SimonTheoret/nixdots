{config, lib, userName, ...}@inputs:
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
    ../hardware/laptop-hardware-configuration.nix
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/ui.nix
  ];

  myAudio.enable = false;
  myAudio.guiControls = false;
  myBluetooth.enable = true;
  myChezMoi.enable = true;
  myCommons.enable = true;
  myEmail.enable = false;
  myDevTools.enable = true;
  myDocker.enable = true;
  myLight.enable = false; # false by default
  myNvidia.enable = false; 
  myUi = {
    enable = false;
    monitorsConfig = false; # My laptop has a single screen
    useGUI = false;
  }; 
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video"] ++
                  optionals (config.myDocker.enable) ["docker"] ++
                  optionals (config.myAudio.enable) ["audio"] ;
  };
}
