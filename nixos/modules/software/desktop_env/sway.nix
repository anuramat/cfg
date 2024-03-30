# https://nixos.wiki/wiki/Sway
# kanshi, cursor in home manager... read
{pkgs, ...}: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      dbus # make sure dbus-update-activation-environment is available
      sway-contrib.inactive-windows-transparency
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };

  # Enabling realtime may improve latency and reduce stuttering, specially in high load scenarios.
  # Enabling this option allows any program run by the "users" group to request real-time priority.
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  #   home-manager.users.myUser = {
  #     home.pointerCursor = {
  #       name = "Adwaita";
  #       package = pkgs.gnome.adwaita-icon-theme;
  #       size = 24;
  #       x11 = {
  #         enable = true;
  #         defaultCursor = "Adwaita";
  #       };
  #     };
  #   };

  services.greetd = {
    enable = true;
  };
  programs.regreet = {enable = true;};
}
