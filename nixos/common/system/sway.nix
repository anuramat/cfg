# https://nixos.wiki/wiki/Sway
{pkgs, ...}: {
  programs.sway = {
    enable = true;
    # TODO doc this
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      dbus # make sure dbus-update-activation-environment is available
      # isnt dbus already in there anyway?
    ];
  };

  # autostart
  programs.bash.loginShellInit = ''
    if [ -z "''${WAYLAND_DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ] && command -v sway &>/dev/null; then
    	if lspci | grep -iq nvidia; then
    		exec sway --unsupported-gpu
    	fi
    	exec sway
    fi
  '';

  # force native wayland support in chrome/electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # TODO doc this
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
