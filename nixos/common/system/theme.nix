{pkgs, ...}: {
  # TODO fuck my life man
  environment.systemPackages = with pkgs; [
    glib # gsettings (gtk etc)
    dracula-theme # TODO where exactly is this used?
    dracula-icon-theme
    hackneyed # windows style cursor
    gnome3.adwaita-icon-theme

    # at least qt makes sense
    adwaita-qt # qt5
    adwaita-qt6
    qt5ct # qt5 gui settings
    qt6ct # qt6 gui settings
  ];
  qt = {
    enable = true; # TODO what does this do
    platformTheme = "qt5ct"; # actually uses both qt5ct and qt6ct
  };
}
