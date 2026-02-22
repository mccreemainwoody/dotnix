{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            limine.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };

    networking = {
        hostName = "nixos-btw";
        networkmanager.enable = true;
        firewall.enable = true;
    };

    my = {
        configurations.sudo.withRagebait = true;

        users.shrek.enable = true;

        profiles = {
            core.enable = true;

            gaming = {
                heroic.enable = true;
                steam = {
                    enable = true;
                    withEnhancers = true;
                    withMonitoring = true;
                };
            };

            graphical.hyprland.enable = true;

            hardware = {
                bluetooth.enable = true;
                nvidia.enable = true;
            };

            login = {
                greetd = {
                    enable = true;
                    initialUser = "shrek";
                };
                plymouth = {
                    enable = true;
                    theme = "connect";
                };
            };

            vim.enable = true;

            virtualisation = {
                docker = {
                    enable = true;
                    rootless = true;
                };
                qemu = {
                    enable = true;
                    withVirtManager = true;
                };
            };
        };
    };

    mt6639 = {
        enable = true;
        archive = ./mtkbt.dat;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.11";
}
