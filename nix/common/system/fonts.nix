{unstable, ...}: {
  fonts = {
    packages = [
      unstable.nerd-fonts.hack
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["Hack Nerd Font"];
      };
    };
  };
}
