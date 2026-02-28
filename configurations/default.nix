{ ... } @ params :

{
    nixosConfigurations = {
        nixos-btw = import ./nixos-btw params;
    };

    nixOnDroidConfigurations = {
        nix-on-droid-btw = import ./nix-on-droid-btw params;
    };
}
