{ config, lib, pkgs, ... } @_ :

let
    cfg = config.my.profiles.graphical.hyprland;
in
{
    options = {
        my.profiles.graphical.hyprland = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
                example = true;
                description =
                    "Enable Hyprland with my configuration on the system.";
            };
        };
    };

    config = lib.mkIf cfg.enable {
        my.profiles.graphical.wayland.enable = true;

        programs.hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };

        environment.systemPackages = with pkgs; [
            kitty
        ];
    };
}
