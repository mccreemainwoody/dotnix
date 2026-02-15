{
    description = "A flake for a pretty nice NixOS configuration.";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        dotfiles = {
            url = "github:mccreemainwoody/dotfiles";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hypryaml = {
            url = "github:mccreemainwoody/hypryaml";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, dotfiles, hypryaml, ... } @_: {
        nixosConfigurations = {
            nixos-btw = let
                    system = "x86_64-linux";
                in
                    nixpkgs.lib.nixosSystem {
                        system = system;
                        modules = let
                            overlays = [
                                (final: prev:
                                    {
                                        hypryaml = hypryaml.packages.${system}.default;
                                    }
                                )
                            ];
                        in [
                            {
                                nixpkgs.overlays = overlays;
                            }
                            ./configuration.nix
                            home-manager.nixosModules.home-manager {
                                home-manager = {
                                    useGlobalPkgs = true;
                                    useUserPackages = true;
                                    backupFileExtension = "bak";
                                    users = {
                                        shrek = {
                                            imports = [
                                                ./home.nix
                                                dotfiles.homeModules.dotfiles
                                            ];
                                        };
                                    };
                                };
                            }
                        ];
                    };
        };
    };
}
