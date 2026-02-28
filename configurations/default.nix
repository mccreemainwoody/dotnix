{ ... } @ params :

{
    nixosConfigurations = {
        nixos-btw = import ./nixos-btw params;
    };
}
