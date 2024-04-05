# https://nixos.wiki/wiki/Sway
# kanshi, cursor in home manager... read
{pkgs, ...}: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      dbus # make sure dbus-update-activation-environment is available
      sway-contrib.inactive-windows-transparency
      swaycons
    ];
  };

  # force native wayland support in chrome/electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  security.pam.services.swaylock = {}; # already done by sway.enable
  # security.pam.loginLimits = [
  #   {
  #     domain = "@users";
  #     item = "rtprio";
  #     type = "-";
  #     value = 1;
  #   }
  # ];
}
