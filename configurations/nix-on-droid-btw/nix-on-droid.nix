{ config, lib, pkgs, ... } :

{
    time.timeZone = "Europe/Paris";

    environment = {
        etcBackupExtension = ".bak";

        packages = with pkgs; [
            vim
            git
        ];
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';

    system.stateVersion = "24.05";
}
