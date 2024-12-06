# vim: fdl=0 fdm=marker
{
  pkgs,
  unstable,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Desktop basics {{{1
    mako # notifications - smaller than fnott and dunst
    swayidle # lock/sleep on idle
    swaylock # lockscreen
    waybar # status bar
    wl-clip-persist # otherwise clipboard contents disappear on exit

    # Browsers {{{1
    inputs.zen-browser.packages.${pkgs.system}.specific
    tor-browser-bundle-bin
    unstable.firefox
    unstable.google-chrome

    # Terminals {{{1
    cool-retro-term
    foot # cpu

    # Settings {{{1
    ddcutil # configure external monitors (eg brightness)
    helvum # pipewire patchbay
    networkmanagerapplet # networking
    pavucontrol # gui audio configuration
    system-config-printer # printer gui
    udiskie # userspace frontend for udisk2
    unstable.avizo # brightness/volume control with overlay indicator
    kanshi # display config daemon
    wl-mirror # screen mirroring

    # Opening stuff {{{1
    nemo # wayland native
    desktop-file-utils # update-desktop-database etc
    wmenu
    j4-dmenu-desktop
    xdg-utils # xdg-open etc
    xdragon # drag and drop from terminal

    # Terminal helpers {{{1
    libnotify # notify-send etc
    playerctl # cli media player controls
    wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout

    # Wallpaper helpers {{{1
    glpaper # shader
    mpvpaper # video
    swaybg # plain

    # Screenshots and screen capture {{{1
    grim # CLI screenshot
    kooha # screen capture with basic gui
    shotman # screenshot, with simple preview afterwards, no markup
    slurp # select screen region
    swappy # markup wrapper for grim+slurp/etc
    wf-recorder # CLI screen capture

    # Comms {{{1
    element-desktop # matrix client
    onionshare # tor-based file-sharing etc
    onionshare-gui # p2p file sharing, chat, website hosting
    # qtox # p2p IM # XXX broken
    # slack # XXX broken
    telegram-desktop
    whatsapp-for-linux # isn't this worthless TODO

    # Misc {{{1
    hyprpicker # simple terminal color picker
    obs-studio
    qalculate-gtk # qalc calculator gui
    spotify
    steam
    unstable.cheese # webcam
    unstable.proton-pass
    unstable.transmission_4-gtk # transmission torrent client gui
    unstable.wallust # better pywal
    wev # wayland event viewer, useful for debugging
    # }}}
  ];
}
