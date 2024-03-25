{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    unstable.google-chrome

    # GUI frontends
    networkmanagerapplet # networking
    unstable.avizo # brightness/volume control with overlay indicator
    pavucontrol # gui audio configuration
    system-config-printer # printer gui

    # Opening stuff
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

    # Random TODO
    cinnamon.nemo # wayland native
    gnome-solanum # really simple one
    gnome.cheese # webcam
    gnome.pomodoro # slightly bloated
    qalculate-gtk # gui for qalc
    spotify
    tor-browser-bundle-bin
    transmission # torrent client
    transmission-gtk # gui wrapper for transmission
    unstable.obsidian # markdown personal knowledge database
    obs-studio # screencasting/streaming
    sageWithDoc # computer algebra
    hyprpicker # gigasimple terminal color picker
    steam
    unstable.vscode
    mesa-demos # some 3d demos
    unstable.neovide # neovim gui
  ];
}
