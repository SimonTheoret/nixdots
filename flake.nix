{
  description = "Nixos config flake"; 

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, config, nixpkgs, home-manager, ... }@inputs:
  {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {
        system = "x86_64-linux";
        inherit inputs;
        userName="simon"; # What is the user's name
        config = inputs.config // {
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
        };
      };
      modules = [
        ./modules/audio.nix
        ./modules/bluetooth.nix
        ./modules/chezmoi.nix
        ./modules/commons.nix 
        ./modules/devtools.nix
        ./modules/docker.nix
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

    # nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [
        #     ./nix/nixfiles/common-config.nix

        #     { nix.settings.trusted-users = [ "simon" ]; }
        #     ./nix/profiles/laptop/laptop.nix

        #     home-manager.nixosModules.home-manager
        #     {
          #       home-manager.useGlobalPkgs = true;
          #       home-manager.useUserPackages = true;

          #       home-manager.extraSpecialArgs = inputs // { laptop = true; };
          #       home-manager.users.simon = import ./home-manager/profiles/i3;
          #     }
          #   ];
          # };

          # nixosConfigurations.server = nixpkgs.lib.nixosSystem {
            #   specialArgs = {
              #     inherit inputs;
              #   };
              #   modules = [
                #     ./nix/nixfiles/common-config.nix

                #     { nix.settings.trusted-users = [ "simon" ]; }

                #     ./nix/profiles/i3-desktop/i3-desktop.nix

                #     home-manager.nixosModules.home-manager
                #     {
                  #       home-manager.useGlobalPkgs = true;
                  #       home-manager.useUserPackages = true;

                  #       home-manager.extraSpecialArgs = inputs // { laptop = false; server = false };
                  #       home-manager.users.simon = import ./home-manager/profiles/i3;
                  #     }
                  #   ];
                  # };
  };
}
