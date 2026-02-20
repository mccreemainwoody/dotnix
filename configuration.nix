{ config, lib, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.plymouth = {
        enable = true;
        theme = "connect";
        themePackages = with pkgs; [
            (adi1090x-plymouth-themes.override {
                selected_themes = [ "connect" ];
            })
        ];
    };

    networking.hostName = "nixos-btw";
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;

    time.timeZone = "Europe/Paris";

    users.users.shrek = {
        isNormalUser = true;
        extraGroups = [ "wheel" "libvirtd" "docker" ];
    };

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                ControllerMode = "bredr"; # Fix frequent Bluetooth audio dropouts
                Experimental = true;
                FastConnectable = true;
            };
            Policy = {
                AutoEnable = true;
            };
        };
    };

    i18n.defaultLocale = "fr_FR.UTF-8";
    i18n.extraLocales = [
        "en_US.UTF-8/UTF-8"
        "zh_CN.UTF-8/UTF-8"
    ];
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
            qt6Packages.fcitx5-chinese-addons
            fcitx5-gtk
        ];
    };

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono 
        nerd-fonts.noto
        noto-fonts-cjk-sans
    ];

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = ''
                    ${pkgs.tuigreet}/bin/tuigreet \
                        --asterisks \
                        --kb-command 10 \
                        --kb-sessions 11 \
                        --kb-power 12 \
                        --issue \
                        --remember \
                        --remember-session \
                        --theme "border=magenta;container=darkgrey;text=magenta;prompt=magenta;time=green;action=lightblue;button=blue;input=yellow" \
                        --time
                '';
            };
            initial_session = {
                command = "${pkgs.hyprland}/bin/start-hyprland";
                user = "shrek";
            };
        };
    };
    services.openssh.enable = true;
    services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
    };
    services.xserver = {
        enable = true;
        videoDrivers = [
            (lib.mkIf config.my.profiles.nvidia.enable "nvidia")
        ];
    };

    programs.gamemode.enable = true;
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };
    programs.hyprlock.enable = true;
    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };

    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
        };
    };

    environment.systemPackages = with pkgs; [
        killall
        nvd
        openssl
        tree
        unzip
        wget
        wl-clipboard
        zip

        docker-buildx
        docker-compose
        git

        dunst
        kitty
        rofi
        tuigreet
        wvkbd
    ];

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    my.configurations.sudo.withRagebait = false;

    my.profiles.vim.enable = true;
    my.profiles.nvidia.enable = true;

    system.stateVersion = "25.11";
}
