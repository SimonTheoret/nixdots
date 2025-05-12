{
  config,
  pkgs,
  lib,
  ...
}:

let
  interface = "wlan0";
in
{

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
