{config, lib, userName, ...}@inputs:
let 
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
../modules/hardware-configuration.nix
../modules/light.nix
../modules/nixconf.nix
../modules/nvidia.nix
../modules/ui.nix
myAudio.enable = true;
myAudio.guiControls = true;
myBluetooth.enable = true;
myChezMoi.enable = true;
myCommons.enable = true;
myDevTools.enable = true;
myDocker.enable = false;
myLight.enable = true; # false by default
myNvidia.enable = false; 
myUi = {
  enable = true;
  monitorsConfig = false; # My laptop has a single screen
  useGUI = true;
}; 
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio"] ++ optionals (config.myDocker.enable) ["docker"] ;
  };
}

