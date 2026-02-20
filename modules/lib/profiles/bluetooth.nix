{ config, lib, ... } @_ :

let
    cfg = config.my.profiles.bluetooth;
in
{
    options = {
        my.profiles.bluetooth = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
                example = true;
                description =
                    "Enable Bluetooth on the system (using my config).";
            };
        };
    };

    config = lib.mkIf cfg.enable {
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
    };
}
