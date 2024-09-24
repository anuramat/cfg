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
    mprocs # job runner
    ncdu # du++: interactive
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
    # ~~~~~~~~~~~~~~~~~~~~~~ MOVE ME {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    age # file encryption
    aria # downloader
    croc # send/receive files through relay with encryption
    distrobox
    exercism # CLI for exercism.org
    fastfetch
    gh # GitHub CLI
    git-filter-repo # rewrite/analyze repository history
    httpie # curl++
    hyprpicker # simple terminal color picker
    mosh # ssh over unstable connections
    parallel # run parallel jobs
    prettyping # ping++
    progress # progress status for cp etc
    pv # pipe viewer
    python311Packages.jupytext
    python311Packages.pyicloud
    qrcp # send files to mobile over Wi-Fi using QR
    rclone # rsync for cloud
    scc # count lines of code
    speedtest-cli
    taskwarrior # CLI todo app
    tealdeer # tldr reimplementation: rust + xdg
    tree-sitter
    unstable.devenv
    unstable.xdg-ninja # checks $HOME for junk
    yt-dlp # download youtube videos
    # ~~~~~~~~~~~~~~~~~~~ god forbid {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    dbeaver-bin # databases
    dive # look into docker image layers
    grpcui
    grpcurl
    kubectl
    kubectx
    podman-compose
    # ~~~~~~~~~~~~~~~~~~~~~~ junk {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    fortune # random quotes
    figlet # fancy banners
    banner
    cowsay
    # }}}
  ];
}
# vim: fdm=marker fdl=0
