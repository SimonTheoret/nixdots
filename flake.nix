{
  description = "Nixos config flake"; 

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let 
	inherit (self) outputs;
	systems = ["aarch64-linux" "i686-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin"];
	forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    #packages = forAllSystems(system: import ./pkgs nixpkgs.legacyPackages.${system});
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs; config = {};};
      modules = [
        ./modules/audio.nix
        ./modules/bluetooth.nix
        ./modules/chezmoi.nix
        ./modules/commons.nix 
        ./modules/devtools.nix
        ./modules/docker.nix
        ./modules/hardware-configuration.nix
        ./modules/home-manager.nix
        ./modules/light.nix
        ./modules/nixconf.nix
        ./modules/nvidia.nix
        ./modules/ui.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs;
        }
      ];
  };
}
}

#        config = {
#          myAudio.enable = true;
#          myBluetooth.enable = true;
#          myChezMoi.enable = true;
#          myCommons.enable = true;
#          myDevTools.enable = true;
#          myDocker.enable = true;
#          myHomeManager.enable = true;
#          myLight.enable = false; # false by default
#          myNvidia.enable = false; 
#          myUi = {
#            enable = true;
#            monitorsConfig = true;
#            useGUI = true;
#          }; 
#        };
