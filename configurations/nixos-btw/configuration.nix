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

    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "fr_FR.UTF-8";
    i18n.extraLocales = [
        "en_US.UTF-8/UTF-8"
        "zh_CN.UTF-8/UTF-8"
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono 
        nerd-fonts.noto
        noto-fonts-cjk-sans
    ];

    services.openssh.enable = true;

    environment.systemPackages = with pkgs; [
        killall
        nvd
        openssl
        tree
        unzip
        wget
        zip

        git
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    my.configurations.sudo.withRagebait = false;

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

    system.stateVersion = "25.11";
}
