{ config, lib, pkgs, inputs, ... } :

let
    dotfiles = inputs.dotfiles;
in
{
    time.timeZone = "Europe/Paris";

    environment = {
        etcBackupExtension = ".bak";

        packages = with pkgs; [
            vim
            git
        ];
    };

    home-manager.config.imports = [
        dotfiles.homeModules.dotfiles
        ./home.nix
    ];

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';

    system.stateVersion = "24.05";
}
