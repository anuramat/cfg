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
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };
  # home-manager.users.myUser = {
  #   home.pointerCursor = {
  #     name = "Adwaita";
  #     package = pkgs.gnome.adwaita-icon-theme;
  #     size = 24;
  #     x11 = {
  #       enable = true;
  #       defaultCursor = "Adwaita";
  #     };
  #   };
  # };
}
