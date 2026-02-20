{ config, lib, ... } @_ :

let
    cfg = config.my.profiles;
in
{
    options = {
        my.profiles.vim = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
                example = true;
                description = "Enable vim on the system.";
            };

            defaultEditor = lib.mkOption {
                type = lib.types.bool;
                default = true;
                example = true;
                description = "Whether vim should be the default editor.";
            };
        };
    };

    config = {
        programs.vim = {
            inherit (cfg.vim)
                enable
                defaultEditor;
        };
    };
}
