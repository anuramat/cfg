# https://nixos.wiki/wiki/Sway
# kanshi, cursor in home manager... read
{
  pkgs,
  unstable,
  ...
}: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      dbus # make sure dbus-update-activation-environment is available
      sway-contrib.inactive-windows-transparency
      swaycons
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
