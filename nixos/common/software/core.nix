{
  pkgs,
  unstable,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # code editors {{{1
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    inputs.zen-browser.packages.${pkgs.system}.specific
    nvi
    unstable.helix
    unstable.vis
    # core {{{1
    unstable.blesh # bash line editor
    bat # cat++: syntax hl
    cod # completion generator (updates on `cmd --help`)
    delta # diff++
    difftastic # diff++: syntax aware using TS
    du-dust # du++
    duf # df++
    entr # file watcher - runs command on change
    watchman # another file watcher
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
    unstable.taskwarrior3 # CLI todo app
    unstable.nb # edgy obsidian?
    unstable.todo # stupid simple but very raw
    unstable.todo-txt-cli # the thing
    tealdeer # tldr reimplementation: rust + xdg
    tgpt # tui for llm apis
    unstable.devenv
    unstable.eza # ls++
    zellij # tmux++
    zoxide # cd++
    # utils {{{1
    rsbkb # rust blackbag - encode/decode tools: crc
    age # file encryption
    aria # downloader
    banner
    croc # send/receive files through relay with encryption
    distrobox
    exercism # CLI for exercism.org
    fastfetch
    figlet # fancy banners
    gh # GitHub CLI
    gnuplot
    httpie # curl++
    mprocs # job runner
    prettyping # ping++
    progress # progress status for cp etc
    pv # pipe viewer
    python311Packages.jupytext
    scc # count lines of code
    speedtest-cli
    unstable.xdg-ninja # checks $HOME for junk
    ## tops {{{2
    btop # best
    ctop # containers
    gotop # cute
    htop # basic
    iotop # detailed io info, requires sudo
    nvitop # nvidia gpu
    podman-tui # podman container status
    unstable.nvtopPackages.full # top for GPUs (doesn't support intel yet)
    zenith-nvidia # top WITH nvidia GPUs
    ## file managers {{{2
    # TODO choose one (or don't)
    yazi
    broot
    lf
    mc
    nnn
    ranger
    vifm
    xplr
    ## backend {{{2
    dbeaver-bin # databases
    dive # look into docker image layers
    grpcui
    grpcurl
    kubectl
    kubectx
    podman-compose
    ## misc {{{2
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
    # graphics {{{1
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
    unstable.lsix # ls for images (uses sixel)
    # video {{{1
    vlc
    mpv
    # davinci-resolve
    handbrake
    unstable.footage
    ffmpeg
    yt-dlp # download youtube videos
    # audio {{{1
    sox # CLI audio processing
    lame # mp3
    alsa-utils
    mimic # foolproof TTS
    piper-tts # good neural TTS
    # docs {{{1
    slides # markdown presentation in terminal
    glow # markdown viewer
    poppler_utils # pdf utils
    ghostscript # postscript/pdf utils
    readability-cli # extracts main content from pages
    okular # reader
    djview # djvu reader
    unstable.zathura # keyboard-centric aio reader
    zotero # TODO do I need this?
    easyocr # neural OCR
    pandoc # markup converter (latex, markdown, etc)
    djvulibre # djvu tools
    xournalpp # pdf markup, handwritten notes
    # }}}
  ];
}
# vim: fdm=marker fdl=0
