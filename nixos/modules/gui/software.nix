{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    google-chrome
    # GUI frontends
    networkmanagerapplet
    unstable.avizo # brightness/volume control with overlay indicator
    pavucontrol # gui audio configuration
    system-config-printer # printer gui
    ###
    waybar # status bar
    tofi # app launcher
    wev # wayland event viewer, useful for debugging
    libnotify # notify-send etc
    mako # notifications
    xdg-utils # xdg-open etc
    desktop-file-utils # update-desktop-database etc
    wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout
    playerctl # cli media player controls
    swaylock-effects # lockscreen, swaylock fork
    swayidle # idle events
    sov # workspace overview for sway

    # Wallpaper helpers
    swaybg # plain
    mpvpaper # video
    glpaper # shader

    # Display settings
    kanshi # plaintext defined display configs
    wlr-randr # interactive cli display configs
    wlay # gui display configs (can output kanshi/sway/wlr-randr files)

    # Screenshots and screen capture
    slurp # select screen region
    grim # CLI screenshot
    shotman # screenshot, with simple preview afterwards, no markup
    swappy # markup wrapper for grim+slurp/etc
    wf-recorder # CLI screen capture
    kooha # screen capture with basic gui
  ];
}
