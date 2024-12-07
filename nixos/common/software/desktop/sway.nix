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

  environment.systemPackages = with pkgs; [
    avizo # brightness/volume control with overlay indicator
    grim # CLI screenshot
    kanshi # display config daemon
    libnotify # notify-send etc
    mako # notifications - smaller than fnott and dunst
    networkmanagerapplet # networking
    slurp # select screen region
    swappy # markup wrapper for grim+slurp/etc
    swaybg # plain
    swayidle # lock/sleep on idle
    swaylock # lockscreen
    udiskie # userspace frontend for udisk2
    waybar # status bar
    wl-clip-persist # otherwise clipboard contents disappear on exit
    wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout
    wl-mirror # screen mirroring
  ];

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
