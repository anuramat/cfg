{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerdfonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["Hack Nerd Font"];
      };
    };
  };
}
