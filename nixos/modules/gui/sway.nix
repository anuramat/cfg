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
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };
}
