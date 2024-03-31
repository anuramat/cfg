_: {
  services.greetd = {
    enable = true;
  };
  programs.regreet = {
    settings = {
      background = {
        # path = "/usr/share/backgrounds/greeter.jpg"
        # fit = "Fill"
      };
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Adwaita";
        font_name = "Hack Nerd Font 16";
        icon_theme_name = "Adwaita";
        theme_name = "Adwaita";
      };
    };
    enable = true;
  };
}
