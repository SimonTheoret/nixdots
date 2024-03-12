{
  description = "Home-manager configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, home-manager, nixpkgs, utils }:
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
      # shell ocnfig part 1 ends here
      
      mkHomeConfiguration = args:
        home-manager.lib.homeManagerConfiguration (rec {
          modules = [ (import ./homenix/home.nix) ] ++ (args.modules or [ ]);
          pkgs = pkgsForSystem (args.system or "x86_64-linux");
        } // {
          inherit (args) extraSpecialArgs;
        });

    in utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ]
    (system: rec { legacyPackages = pkgsForSystem system; }) // {
      

      # shell config part 2 starts here
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell { packages = with pkgs; [ nil nixfmt ]; };
      });
      # shell config part 2 ends here

      #
      # non-system suffixed items should go here
      nixosModules.home = import ./homenix/home.nix; # attr set or list

      homeConfigurations.simon =
        mkHomeConfiguration { extraSpecialArgs = { }; };

      # homeConfigurations.server = mkHomeConfiguration {
      #   extraSpecialArgs = {
      #     withGUI = false;
      #     isDesktop = false;
      #     networkInterface = "enp68s0";
      #   };
      # };
      #
      # homeConfigurations.laptop = mkHomeConfiguration {
      #   extraSpecialArgs = {
      #     withGUI = true;
      #     isDesktop = true;
      #     networkInterface = "wlp1s0";
      #   };
      # };
      #
      # homeConfigurations.work = mkHomeConfiguration {
      #   modules = [ ({lib,...}:
      #   {
      #     home.username = lib.mkForce "jringer";
      #     home.homeDirectory = lib.mkForce "/home/jringer";
      #   })];
      #   extraSpecialArgs = {
      #     withGUI = true;
      #     isDesktop = true;
      #     networkInterface = "wlp1s0";
      #   };
      # };
      #
      # homeConfigurations.mac-mini = mkHomeConfiguration {
      #   extraSpecialArgs = {
      #     withGUI = false;
      #     isDesktop = false;
      #     networkInterface = "en1";
      #   };
      # };

      inherit home-manager;
      inherit (home-manager) packages;
    };
}
