{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Browsers
    tor-browser-bundle-bin
    unstable.firefox
    unstable.google-chrome

    # terminals {{{1
    cool-retro-term
    unstable.foot # cpu
    unstable.alacritty # gpu, crossplatform
    unstable.kitty

    # Settings
    networkmanagerapplet # networking
    unstable.avizo # brightness/volume control with overlay indicator
    ddcutil # configure external monitors
    pavucontrol # gui audio configuration
    system-config-printer # printer gui
    helvum # pipewire patchbay
    udiskie # userspace frontend for udisk2

    # Opening stuff
    cinnamon.nemo # wayland native
    xdragon # drag and drop from terminal
    tofi # app launcher
    xdg-utils # xdg-open etc
    desktop-file-utils # update-desktop-database etc

    # Big chunks
    waybar # status bar
    mako # notifications - smaller than fnott and dunst
    swaylock # lockscreen
    swayidle # lock/sleep on idle

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
    wl-clip-persist
    unstable.wallust # better pywal
    spotify
    unstable.keymapp # ZSA keyboard thing
    unstable.proton-pass
    unstable.transmission_4-gtk # transmission torrent client gui
    unstable.cheese # webcam
    obs-studio
    steam
    hyprpicker # simple terminal color picker

    # Comms {{{1
    element-desktop # matrix client
    onionshare # tor-based file-sharing etc
    onionshare-gui # p2p file sharing, chat, website hosting
    qtox # p2p IM
    slack
    telegram-desktop
    whatsapp-for-linux # isn't this worthless TODO
  ];
}
