# vim: fdl=0 fdm=marker
{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Desktop basics {{{1
    waybar # status bar
    mako # notifications - smaller than fnott and dunst
    swaylock # lockscreen
    swayidle # lock/sleep on idle

    # Browsers {{{1
    tor-browser-bundle-bin
    unstable.firefox
    unstable.google-chrome

    # Terminals {{{1
    cool-retro-term
    unstable.foot # cpu
    unstable.alacritty # gpu, crossplatform
    unstable.kitty

    # Settings {{{1
    ddcutil # configure external monitors
    helvum # pipewire patchbay
    networkmanagerapplet # networking
    pavucontrol # gui audio configuration
    system-config-printer # printer gui
    udiskie # userspace frontend for udisk2
    unstable.avizo # brightness/volume control with overlay indicator
    way-displays # auto manager
    wlay # gui display configs (can output kanshi/sway/wlr-randr files)

    # Opening stuff {{{1
    cinnamon.nemo # wayland native
    xdragon # drag and drop from terminal
    tofi # app launcher
    xdg-utils # xdg-open etc
    desktop-file-utils # update-desktop-database etc

    # Terminal helpers {{{1
    libnotify # notify-send etc
    wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout
    playerctl # cli media player controls

    # Wallpaper helpers {{{1
    swaybg # plain
    mpvpaper # video
    glpaper # shader

    # Screenshots and screen capture {{{1
    slurp # select screen region
    grim # CLI screenshot
    shotman # screenshot, with simple preview afterwards, no markup
    swappy # markup wrapper for grim+slurp/etc
    wf-recorder # CLI screen capture
    kooha # screen capture with basic gui

    # Misc {{{1
    wl-clip-persist # otherwise clipboard contents disappear on exit
    unstable.wallust # better pywal
    spotify
    unstable.keymapp # ZSA keyboard thing
    unstable.proton-pass
    unstable.transmission_4-gtk # transmission torrent client gui
    unstable.cheese # webcam
    obs-studio
    steam
    hyprpicker # simple terminal color picker
    wev # wayland event viewer, useful for debugging

    # Comms {{{1
    element-desktop # matrix client
    onionshare # tor-based file-sharing etc
    onionshare-gui # p2p file sharing, chat, website hosting
    qtox # p2p IM
    slack
    telegram-desktop
    whatsapp-for-linux # isn't this worthless TODO

    # }}}
  ];
}
