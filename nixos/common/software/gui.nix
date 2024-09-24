{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # ~~~~~~~~~~~~~~~~~~~~~~ comms {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    element-desktop # matrix client
    slack
    discord
    telegram-desktop
    whatsapp-for-linux
    qtox # p2p IM
    onionshare-gui # p2p file sharing, chat, website hosting
    # ~~~~~~~~~~~~~~~~~~~~ browsers {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    unstable.google-chrome
    unstable.firefox
    unstable.qutebrowser
    unstable.vivaldi
    # unstable.vivaldi-ffmpeg-codecs # proprietary codecs TODO properly install
    tor-browser-bundle-bin
    # ~~~~~~~~~~~~~~~~~~~~ terminals {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    cool-retro-term # cute terminal
    # ~~~~~~~~~~~~~~~~~~~~ graphics {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    # krita # raster graphics, digital art
    inkscape-with-extensions # vector graphics
    gimp-with-plugins # raster graphics
    imagemagickBig # CLI image manipulation
    libwebp # tools for WebP image format
    exiftool # read/write EXIF metadata
    mypaint # not-ms-paint
    nomacs # image viewer
    # TODO find the best??
    imv # terminal image viewer
    swayimg # terminal image viewer
    # ~~~~~~~~~~~~~~~~~~~~~~ video {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    vlc # video player
    mpv # minimalistic video player
    # davinci-resolve # video editor etc
    handbrake # ghb - GUI for video converting
    unstable.footage # simple video editor
    ffmpeg # CLI multimedia processing
    # ~~~~~~~~~~~~~~~~~~~~~~ audio {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    sox # CLI audio processing
    # ~~~~~~~~~~~~~~~~~~~~~~ docs {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    okular # reader
    djview # djvu reader
    zathura # keyboard-centric aio reader
    zotero
    easyocr # neural OCR
    pandoc # markup converter (latex, markdown, etc)
    djvulibre # djvu tools
    xournalpp # pdf markup, handwritten notes
    xfig # vector graphics, old as FUCK
    # ~~~~~~~~~~~~~~~~~~~~~~ misc {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    unstable.keymapp # ZSA keyboard thing
    gnome-solanum # simple pomodoro
    gnome.cheese # webcam
    gnome.pomodoro # slightly bloated pomodoro
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
    rpi-imager
    # }}}
  ];
}
# vim: fdm=marker fdl=0
