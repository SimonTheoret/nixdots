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
        userName="simon";
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
          home-manager.users.simon = import ./modules/home-manager.nix;
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
