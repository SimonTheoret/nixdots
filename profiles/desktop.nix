{...}:
{
imports = [
../audio.nix
../bluetooth.nix
../chezmoi.nix
../commons.nix
../devtools.nix
../docker.nix
../hardware-configuration.nix
../home-manager.nix
../light.nix
../nixconf.nix
../nvidia.nix
../ui.nix
];
myAudio.enable = true;
myBluetooth.enable = true;
myChezMoi.enable = true;
myCommons.enable = true;
myDevTools.enable = true;
myDocker.enable = true;
myHomeManager.enable = true;
myLight.enable = false; # false by default
myNvidia.enable = false; 
myUi = {
  enable = true;
  monitorsConfig = true;
  useGUI = true;
}; 
}
