{ pkgs, ... } @_ :

{
    home.my-dotfiles.enable = true;

    home.packages = with pkgs; [ rustup ];

    programs.carapace.enable = true;
    programs.fastfetch.enable = true;
    programs.neovim = {
        defaultEditor = true;
        enable = true;
        extraPackages = with pkgs; [
            gcc
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

    home.stateVersion = "24.05";
}
