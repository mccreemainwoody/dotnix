{ pkgs, ... }:

{
    boot = {
        kernelPackages = pkgs.linuxKernel.packages.linux_7_0;
        loader.systemd-boot.enable = true;
    };

    my = {
        configurations.sudo.withRagebait = true;

        profiles = {
            core.enable = true;
            vim.enable = true;
            virtualisation.docker = {
                enable = true;
                rootless = true;
            };
        };
    };

    users.users.intern = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "25.11";
}
