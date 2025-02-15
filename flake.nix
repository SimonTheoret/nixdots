{
  description = "Nixos config flake"; 

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let 
	inherit (self) outputs;
	systems = ["aarch64-linux" "i686-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin"];
	forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs; userName="simon";};
      modules = [
	      ./profiles/desktop.nix
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs; userName="simon";};
      modules = [
	      ./profiles/laptop.nix
      ];
    };

  };
}
