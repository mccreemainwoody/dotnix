{
    description = "A flake for a pretty nice NixOS configuration.";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-on-droid = {
            url = "github:nix-community/nix-on-droid";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
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

    outputs = { self, home-manager, ... } @ inputs :
    let
        all_inputs = inputs // {
            modules = [
                home-manager.nixosModules.home-manager
                ./modules
                ./overlays
                ./users
            ];
        };

        configurations = import ./configurations all_inputs;
    in
    {
        inherit (configurations)
            nixosConfigurations
            nixOnDroidConfigurations;
    };
}
