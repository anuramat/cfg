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
    ripgrep # grep++
    ripgrep-all # ripgrep over pdf etc
    rmtrash # rm but to trash
    starship # PS1 rice
    unstable.eza # ls++
    zellij # tmux++
    zoxide # cd++
    # ~~~~~~~~~~~~~~~~~~~ often used {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    taskwarrior # CLI todo app
    tealdeer # tldr reimplementation: rust + xdg
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
    # ~~~~~~~~~~~~~~~~~~~~~~ grpc {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    grpcui # postman for grpc
    grpcurl # curl for grpc
    # ~~~~~~~~~~~~~~~~~~~~~~ kube {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    kubectx
    kubectl
    # ~~~~~~~~~~~~~~~~~~~~~~ rare {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    unstable.devenv
    distrobox
    hyprpicker # simple terminal color picker
    gh # GitHub CLI
    git-filter-repo # rewrite/analyze repository history
    nix-alien
    lsix # ls for images (uses sixel)
    httpie # curl++
    prettyping # ping++
    parallel # run parallel jobs
    scc # count lines of code
    slides # markdown presentation in terminal
    peco # interactive filtering
    aria # downloader
    progress # progress status for cp etc
    pv # pipe viewer
    mprocs # job runner
    glow # markdown viewer
    tree-sitter # needed to generate some grammars
    age # file encryption
    croc # send/receive files through relay with encryption
    readability-cli # extracts main content from pages
    fastfetch # neo-neofetch
    exercism # CLI for exercism.org
    ghostscript # postscript/pdf utils
    mosh # ssh over unstable connections
    nix-index
    onionshare # tor-based file-sharing etc
    poppler_utils # pdf utils
    qrcp # send files to mobile over Wi-Fi using QR
    rclone # rsync for cloud
    speedtest-cli
    unstable.xdg-ninja # checks $HOME for junk
    python311Packages.pyicloud
    python311Packages.jupytext
    w3m # text based web browser
    yt-dlp # download youtube videos
    fortune # random quotes
    figlet # fancy banners
    banner
    cowsay
    docker-compose
    podman-compose
    dive # look into docker image layers
    dbeaver-bin # databases
    # ~~~~~~~~~~~~~~~~~~~~~ passive {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    # }}}
  ];
}
# vim: fdm=marker fdl=0
