{
  description = "Nixos config flake"; # Cute

  nixConfig = {
    substituers = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    # once the inputs are resolved, they're passed to the function `outputs` along
    # with with `self`, which is the directory of this flake in the store.

    let

      # shell config part 1
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });
      pkgsForSystem = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixosDesktopSway = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nix/nixfiles/common-config.nix

          { nix.settings.trusted-users = [ "simon" ]; }

          ./nix/profiles/wayland-desktop/wayland-desktop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.simon = import ./home-manager/profiles/sway;
          }
        ];
      };
      nixosConfigurations.nixosDesktopi3 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nix/nixfiles/common-config.nix

          { nix.settings.trusted-users = [ "simon" ]; }

          ./nix/profiles/i3-desktop/i3-desktop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.simon = import ./home-manager/profiles/i3;
          }
        ];
      };
      nixosConfigurations.nixoslaptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nix/nixfiles/common-config.nix

          { nix.settings.trusted-users = [ "simon" ]; }
          ./nix/profiles/laptop/laptop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.simon = import ./home-manager/profiles/i3;
          }
        ];
      };

      # shell config part 2 starts here
      devShells = forEachSupportedSystem
        ({ pkgs }: { # Shell for editing my dotfiles
          default = pkgs.mkShell {
            packages = with pkgs; [
              nil
              nixfmt
              nodePackages_latest.bash-language-server
              shellcheck
              shfmt
            ];
          };
        });
      # shell config part 2 ends here
    };
}
