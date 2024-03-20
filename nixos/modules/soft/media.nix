{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ### Media
    gimp-with-plugins # raster graphics
    # krita # raster graphics, digital art
    # inkscape-with-extensions # vector graphics
    # davinci-resolve # video editor etc
  ];
}
