{pkgs, ...}: {
  # TODO
  environment.systemPackages = with pkgs; [
    glib # gsettings (gtk etc)
    dracula-theme
    dracula-icon-theme
    hackneyed # windows style cursor
    apple-cursor
    gnome3.adwaita-icon-theme

    adwaita-qt # qt5
    adwaita-qt6
    qt5ct # qt5 gui settings
    qt6ct # qt6 gui settings
  ];
  qt = {
    enable = true;
    platformTheme = "qt5ct"; # actually uses both qt5ct and qt6ct
  };
}
