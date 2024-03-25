{
  pkgs,
  unstable,
  ...
}: let
  # TODO make sure we need this, refer to nixos wiki sway page
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
in {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      sway-contrib.inactive-windows-transparency
      dbus-sway-environment
      unstable.sov # workspace overview for sway # TODO use this
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.dbus.enable = true;

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

  # # kanshi systemd service
  # systemd.user.services.kanshi = {
  #   description = "kanshi daemon";
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
  #   };
  # };

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

  # security.pam.services.swaylock = {}; # done automatically by programs.sway.enable
}
