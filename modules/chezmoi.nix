{ config, pkgs, lib, ... }:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myChezMoi;
in {
  options.myChezMoi = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Use Chezmoi to manage dotfiles" ;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.chezmoi];
  };
}
