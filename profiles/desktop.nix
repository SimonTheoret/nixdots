{config, lib, userName, home-manager, ...}@inputs:
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
#../modules/home-manager.nix
../modules/light.nix
../modules/nixconf.nix
../modules/nvidia.nix
../modules/ui.nix
#home-manager.nixosModules.home-manager {
#  home-manager.useGlobalPkgs = true;
#  home-manager.useUserPackages = true;
#  home-manager.users.${userName} = import ../modules/home-manager.nix;
#  home-manager.extrSpecialArgs = {inherit inputs;};
#}
];
myAudio.enable = true;
myAudio.guiControls = true;
myBluetooth.enable = true;
myChezMoi.enable = true;
myCommons.enable = true;
myDevTools.enable = true;
myDocker.enable = true;
#myHomeManager.enable = true;
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
}

