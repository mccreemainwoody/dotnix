{
    nixpkgs,
    home-manager,
    dotfiles,
    mediatek-m6639-module,
    modules,
    ...
} @ inputs :

let
    system = "x86_64-linux";
in
    nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs system; };
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
