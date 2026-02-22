{ config, lib, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos-btw";
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;

    my.configurations.sudo.withRagebait = false;

    my.profiles.core.enable = true;
    my.profiles.gaming = {
        heroic.enable = true;
        steam = {
            enable = true;
            withEnhancers = true;
            withMonitoring = true;
        };
    };
    my.profiles.hardware = {
        bluetooth.enable = true;
        nvidia.enable = true;
    };
    my.profiles.graphical.hyprland.enable = true;
    my.profiles.login = {
        greetd.enable = true;
        plymouth = {
            enable = true;
            theme = "connect";
        };
    };
    my.profiles.vim.enable = true;
    my.profiles.virtualisation = {
        docker = {
            enable = true;
            rootless = true;
        };
        qemu = {
            enable = true;
            withVirtManager = true;
        };
    };

    my.users.shrek.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.11";
}
