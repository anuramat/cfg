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
    fzf # fuzzy finder
    ghq # git repository manager
    libqalculate # `qalc` - advanced calculator
    ncdu # du++: interactive
    parallel # run parallel jobs
    ripgrep # grep++
    ripgrep-all # ripgrep over pdf etc
    rmtrash # rm but to trash
    starship # PS1 rice
    tasksh
    taskwarrior # CLI todo app
    tealdeer # tldr reimplementation: rust + xdg
    tgpt # tui for llm apis
    unstable.devenv
    unstable.eza # ls++
    zellij # tmux++
    zoxide # cd++
    # ~~~~~~~~~~~~~~~~~~~~~~ utils {{{1 ~~~~~~~~~~~~~~~~~~~~~~ #
    age # file encryption
    aria # downloader
    banner
    croc # send/receive files through relay with encryption
    distrobox
    exercism # CLI for exercism.org
    fastfetch
    figlet # fancy banners
    gh # GitHub CLI
    httpie # curl++
    mprocs # job runner
    prettyping # ping++
    progress # progress status for cp etc
    pv # pipe viewer
    python311Packages.jupytext
    scc # count lines of code
    speedtest-cli
    unstable.xdg-ninja # checks $HOME for junk
    ## ~~~~~~~~~~~~~~~~~~~~~~ tops {{{2 ~~~~~~~~~~~~~~~~~~~~~~~ #
    btop # best
    ctop # containers
    gtop
    gotop
    htop # basic
    iotop
    nvitop # nvidia gpu
    podman-tui # podman container status
    unstable.nvtopPackages.full # top for GPUs (doesn't support intel yet)
    ## ~~~~~~~~~~~~~~~~~~ file managers {{{2 ~~~~~~~~~~~~~~~~~~ #
    # TODO choose one (or don't)
    broot
    lf
    mc
    nnn
    ranger
    vifm
    xplr
    ## ~~~~~~~~~~~~~~~~~~~~~ backend {{{2 ~~~~~~~~~~~~~~~~~~~~~ #
    dbeaver-bin # databases
    dive # look into docker image layers
    grpcui
    grpcurl
    kubectl
    kubectx
    podman-compose
    ## ~~~~~~~~~~~~~~~~~~~~~~ misc {{{2 ~~~~~~~~~~~~~~~~~~~~~~~ #
    git-filter-repo # rewrite/analyze repository history
    mesa-demos # some 3d demos
    mosh # ssh over unstable connections
    python311Packages.pyicloud
    qalculate-gtk # qalc calculator gui
    qrcp # send files to mobile over Wi-Fi using QR
    rclone # rsync for cloud
    cowsay
    fortune # random quotes
    rpi-imager
    tree-sitter
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
    lame # mp3
    alsa-utils
    mimic # foolproof TTS
    piper-tts # good neural TTS
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
    # ~~~~~~~~~~~~~~~~~~~~~ generic {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
      ];
    })
    spotify
    steam
    unstable.keymapp # ZSA keyboard thing
    transmission-gtk # transmission torrent client gui
    gnome-solanum # simple pomodoro
    gnome.cheese # webcam
    hyprpicker # simple terminal color picker
    # }}}
  ];
}
# vim: fdm=marker fdl=0
