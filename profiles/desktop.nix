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
    ../modules/light.nix
    ../modules/nixconf.nix
    ../modules/nvidia.nix
    ../modules/ui.nix
    ../modules/wireless.nix
    ../hardware/desktop-hardware-configuration.nix
  ];
  myAudio.enable = true;
  myAudio.guiControls = true;
  myBluetooth.enable = true;
  myChezMoi.enable = true;
  myCommons.enable = true;
  myEmail.enable = true;
  myDevTools.enable = true;
  myDocker.enable = false;
  myLight.enable = false; # false by default
  myNvidia.enable = true; 
  myUi = {
    enable = true;
    monitorsConfig = true;
    useGUI = true;
  }; 
  myWireless.enable = false;
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video"] ++
    optionals (config.myDocker.enable) ["docker"] ++
    optionals (config.myAudio.enable) ["audio"] ;
  };
  environment.variables = {
    NIXOS_CONF = "desktop";
  };
}
