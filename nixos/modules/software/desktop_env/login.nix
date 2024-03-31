_: {
  services.greetd = {
    enable = true;
  };
  programs.regreet = {
    settings = ''
      [background]
      # path = "/usr/share/backgrounds/greeter.jpg"
      # fit = "Fill"
      [env]
      # ENV_VARIABLE = "value"
      [GTK]
      # Whether to use the dark theme
      application_prefer_dark_theme = true
      # Cursor theme name
      cursor_theme_name = "Adwaita"
      # Font name and size
      font_name = "Hack Nerd Font 16"
      # Icon theme name
      icon_theme_name = "Adwaita"
      # GTK theme name
      theme_name = "Adwaita"
    '';
    enable = true;
  };
}
