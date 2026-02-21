{ inputs, modules } :

let
    inherit (inputs)
        nixpkgs
        home-manager
        dotfiles
        mediatek-m6639-module;
    system = "x86_64-linux";
in
    nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
            inherit inputs;
            inherit system;
        };
        modules = modules ++ [
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
            mediatek-m6639-module.nixosModules.default
        ];
    }
