{
  description = "Nixos config flake"; #Cute

  nixConfig = {
    substituers =
      [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, ... }@inputs:
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
      nixosConfigurations.nixosDesktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixfiles/common-config.nix

          { nix.settings.trusted-users = [ "simon" ]; }
          ./profiles/desktop/desktop.nix
        ];
      };
      nixosConfigurations.nixoslaptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixfiles/common-config.nix

          { nix.settings.trusted-users = [ "simon" ]; }
          ./profiles/laptop/laptop.nix
        ];
      };

      # shell config part 2 starts here
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell { packages = with pkgs; [ nil nixfmt ]; };
      });
      # shell config part 2 ends here
    };
}
