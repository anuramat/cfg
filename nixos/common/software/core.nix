{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # ~~~~~~~~~~~~~~~~~~ code editors {{{1 ~~~~~~~~~~~~~~~~~~~ #
    unstable.emacs-gtk
    unstable.neovim
    nvi
    unstable.helix
    unstable.vis
    # ~~~~~~~~~~~~~~~~~~~~~~ core {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    bat # cat++: syntax hl
    cod # completion generator (updates on `cmd --help`)
    delta # diff++
    difftastic # diff++: syntax aware using TS
    du-dust # du++
    duf # df++
    entr # file watcher - runs command on change
    fd # find++
    taskwarrior # CLI todo app
    fzf # fuzzy finder
    ghq # git repository manager
    libqalculate # `qalc` - advanced calculator
    mprocs # job runner
    ncdu # du++: interactive
    parallel # run parallel jobs
    progress # progress status for cp etc
    pv # pipe viewer
    unstable.devenv
    ripgrep # grep++
    ripgrep-all # ripgrep over pdf etc
    rmtrash # rm but to trash
    starship # PS1 rice
    unstable.eza # ls++
    zellij # tmux++
    zoxide # cd++
    # ~~~~~~~~~~~~~~~~~~~~~~ tops {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    btop # best
    ctop # containers
    gtop
    gotop
    htop # basic
    iotop
    nvitop # nvidia gpu
    podman-tui # podman container status
    unstable.nvtopPackages.full # top for GPUs (doesn't support intel yet)
    # ~~~~~~~~~~~~~~~~~~ file managers {{{1 ~~~~~~~~~~~~~~~~~~ #
    # TODO choose one (or don't)
    broot
    lf
    mc
    nnn
    ranger
    vifm
    xplr
    # ~~~~~~~~~~~~~~~~~~~~~ moveme {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    age # file encryption
    aria # downloader
    croc # send/receive files through relay with encryption
    distrobox
    exercism # CLI for exercism.org
    httpie # curl++
    fastfetch
    # ~~~~~~~~~~~~~~~~~~~~~ backend {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    dbeaver-bin # databases
    dive # look into docker image layers
    grpcui
    grpcurl
    kubectl
    kubectx
    podman-compose
    # ~~~~~~~~~~~~~~~~~~~~~~ comms {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    discord
    element-desktop # matrix client
    onionshare # tor-based file-sharing etc
    onionshare-gui # p2p file sharing, chat, website hosting
    qtox # p2p IM
    slack
    telegram-desktop
    whatsapp-for-linux
    # ~~~~~~~~~~~~~~~~~~~~ browsers {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    unstable.google-chrome
    unstable.firefox
    unstable.vivaldi
    tor-browser-bundle-bin
    # ~~~~~~~~~~~~~~~~~~~~ terminals {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    cool-retro-term # cute terminal
    # ~~~~~~~~~~~~~~~~~~~~ graphics {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    krita # raster graphics, digital art
    inkscape-with-extensions # vector graphics
    gimp-with-plugins # raster graphics
    imagemagickBig # CLI image manipulation
    libwebp # tools for WebP image format
    exiftool # read/write EXIF metadata
    mypaint # not-ms-paint
    nomacs # image viewer
    xfig # vector graphics, old as FUCK
    # TODO find the best??
    # they all kinda suck:
    imv # image viewer
    swayimg # image viewer
    lsix # ls for images (uses sixel)
    # ~~~~~~~~~~~~~~~~~~~~~~ video {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    vlc
    mpv
    davinci-resolve
    handbrake
    unstable.footage
    ffmpeg
    yt-dlp # download youtube videos
    # ~~~~~~~~~~~~~~~~~~~~~~ audio {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    sox # CLI audio processing
    mimic # TTS
    # ~~~~~~~~~~~~~~~~~~~~~~ docs {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    slides # markdown presentation in terminal
    glow # markdown viewer
    poppler_utils # pdf utils
    ghostscript # postscript/pdf utils
    readability-cli # extracts main content from pages
    okular # reader
    djview # djvu reader
    zathura # keyboard-centric aio reader
    zotero
    easyocr # neural OCR
    pandoc # markup converter (latex, markdown, etc)
    djvulibre # djvu tools
    xournalpp # pdf markup, handwritten notes
    # ~~~~~~~~~~~~~~~~~~~~~~ misc {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
      ];
    })
    spotify
    steam
    # ~~~~~~~~~~~~~~~~~~~ rarely used {{{1 ~~~~~~~~~~~~~~~~~~~ #
    banner
    cowsay
    figlet # fancy banners
    fortune # random quotes
    gnome-solanum # simple pomodoro
    gnome.cheese # webcam
    mesa-demos # some 3d demos
    qalculate-gtk # qalc calculator gui
    rpi-imager
    transmission-gtk # transmission torrent client gui
    unstable.keymapp # ZSA keyboard thing
    hyprpicker # simple terminal color picker
    gh # GitHub CLI
    git-filter-repo # rewrite/analyze repository history
    mosh # ssh over unstable connections
    prettyping # ping++
    python311Packages.jupytext
    python311Packages.pyicloud
    qrcp # send files to mobile over Wi-Fi using QR
    rclone # rsync for cloud
    scc # count lines of code
    speedtest-cli
    tealdeer # tldr reimplementation: rust + xdg
    tree-sitter
    unstable.xdg-ninja # checks $HOME for junk
    # }}}
  ];
}
# vim: fdm=marker fdl=0
