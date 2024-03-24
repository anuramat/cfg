{unstable, ...}: {
  fonts = {
    packages = [
      unstable.nerdfonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["Hack Nerd Font"];
      };
    };
  };
}
