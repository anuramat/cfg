{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Browsers
    unstable.google-chrome
    unstable.firefox
    unstable.qutebrowser
    unstable.vivaldi
    unstable.vivaldi-ffmpeg-codecs # proprietary codecs
    tor-browser-bundle-bin

    # Terminals
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    unstable.alacritty-theme
    cool-retro-term # cute terminal

    # Settings
    networkmanagerapplet # networking
    unstable.avizo # brightness/volume control with overlay indicator
    pavucontrol # gui audio configuration
    system-config-printer # printer gui
    helvum # pipewire patchbay

    # Opening stuff
    cinnamon.nemo # wayland native
    xdragon # drag and drop from terminal
    tofi # app launcher
    xdg-utils # xdg-open etc
    desktop-file-utils # update-desktop-database etc

    # Big chunks
    waybar # status bar
    mako # notifications
    swaylock
    # swaylock-effects # lockscreen, swaylock fork
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
    kanshi # daemon, reads a plaintext config
    wlr-randr # imperative cli display settings
    wlay # gui display configs (can output kanshi/sway/wlr-randr files)
    way-displays # auto manager

    # Screenshots and screen capture
    slurp # select screen region
    grim # CLI screenshot
    shotman # screenshot, with simple preview afterwards, no markup
    swappy # markup wrapper for grim+slurp/etc
    wf-recorder # CLI screen capture
    kooha # screen capture with basic gui

    # Misc
    gnome-solanum # simple pomodoro
    gnome.cheese # webcam
    gnome.pomodoro # slightly bloated pomodoro
    hyprpicker # gigasimple terminal color picker
    mesa-demos # some 3d demos
    # screencasting/streaming
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
      ];
    })
    qalculate-gtk # qalc calculator gui
    spotify
    steam # games
    transmission-gtk # transmission torrent client gui
    udiskie # userspace frontend for udisk2
  ];
}
