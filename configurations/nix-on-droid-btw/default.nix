{
    nixpkgs,
    nix-on-droid,
    ...
} @ inputs :

let
    system = "aarch64-linux";
in
    nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { inherit system; };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./nix-on-droid.nix ];
    }
