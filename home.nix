{ config, pkgs, ... } @_ :

{
    home.username = "shrek";
    home.homeDirectory = "/home/shrek";
    home.packages = with pkgs; [
        rustup

        brave
        evince
        grim
        pcmanfm
        slurp
        spotify
        virt-manager
    ];

    programs.btop.enable = true;
    programs.carapace.enable = true;
    programs.discord = {
        enable = true;
        package = pkgs.discord-canary;
    };
    programs.fastfetch.enable = true;
    programs.feh.enable = true;
    programs.neovim = {
        defaultEditor = true;
        enable = true;
        extraPackages = with pkgs; [
            ripgrep
        ];
        extraPython3Packages = pyPkgs: with pyPkgs; [
            pynvim
            jedi
            flake8
            black
            pylint
        ];
        withNodeJs = true;
        withPython3 = true;
    };
    programs.nushell.enable = true;
    programs.uv.enable = true;
    programs.waybar.enable = true;

    services.hypridle.enable = true;
    services.hyprpaper.enable = true;

    xdg.configFile."hypr/hyprland/overrides.conf" = {
        text = ''
            exec-once = fcitx5 -d
        '';
        force = true;
    };

    home.stateVersion = "25.11";
}
