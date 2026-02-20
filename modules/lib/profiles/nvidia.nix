{ config, lib, ... } @_ :

let
    cfg = config.my.profiles.nvidia;
in
{
    options = {
        my.profiles.nvidia = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
                example = true;
                description = "Enable Nvidia GPU handlers on the system.";
            };
        };
    };

    config = lib.mkIf cfg.enable {
        hardware.graphics.enable = true;

        hardware.nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.stable; 
            open = true;
            nvidiaSettings = true;
        };
    };
}
