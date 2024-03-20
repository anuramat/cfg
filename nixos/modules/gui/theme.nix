{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    glib # gsettings (gtk etc)
    qt5ct # qt5 gui settings
    qt6ct # qt6 gui settings
    adwaita-qt
    dracula-theme
    dracula-icon-theme
    hackneyed
    gnome3.adwaita-icon-theme
  ];
}
