{ config, lib, pkgs, ... }:

{

  imports = [ ../../home-common.nix ];

  home.packages = with pkgs; [ flashfocus autotiling ];

  programs.autorandr = import ../../../packages/autorandr/autorandr.nix;

  #Picom
  services.picom.enable = true;

  #dunst notifications
  services.dunst = { enable = true; };

  #i3
  xsession = import (../../../packages/i3/i3.nix) { inherit lib; };

}
