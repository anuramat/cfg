{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Terminals
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    unstable.alacritty-theme
    cool-retro-term # cute terminal

    # GUI frontends
    networkmanagerapplet # networking
    unstable.avizo # brightness/volume control with overlay indicator
    pavucontrol # gui audio configuration
    system-config-printer # printer gui

    # Opening stuff
    cinnamon.nemo # wayland native
    xdragon # drag and drop from terminal
    tofi # app launcher
    xdg-utils # xdg-open etc
    desktop-file-utils # update-desktop-database etc

    # Big chunks
    waybar # status bar
    mako # notifications
    swaylock-effects # lockscreen, swaylock fork
    swayidle # idle events

    # Debug stuff
    wev # wayland event viewer, useful for debugging

    # Terminal helpers
    libnotify # notify-send etc
    wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout
    playerctl # cli media player controls

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
