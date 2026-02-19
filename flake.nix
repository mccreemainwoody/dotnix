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
        mediatek-m6639-module = {
            url = "github:clemenscodes/linux-mediatek-mt6639-bluetooth-kernel-module";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        dotfiles,
        hypryaml,
        mediatek-m6639-module,
        ...
    } @_: {
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
                            mediatek-m6639-module.nixosModules.default
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
