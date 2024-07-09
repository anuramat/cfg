{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # ~~~~~~~~~~~~~~~~~~~~~~ core {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    bash
    bc # simple calculator
    coreutils-full
    coreutils-prefixed # good for mac compatibility
    curl
    file
    gcc
    git
    gnumake
    killall
    less
    lsof
    nvi # vi clone
    tree
    unrar-wrapper
    unzip
    util-linux # was already installed but whatever
    wget
    zip
    # ~~~~~~~~~~~~~~~~~~ code editors {{{1 ~~~~~~~~~~~~~~~~~~~ #
    unstable.emacs-gtk
    unstable.neovim
    nvi
    unstable.helix
    unstable.vis
    # ~~~~~~~~~~~~~ modern terminal goodies {{{1 ~~~~~~~~~~~~~ #
    bash-completion
    ghq # git repository manager
    bat # better cat with syntax hl
    cod # completion generator (updates on `cmd --help`)
    delta # better diffs
    difftastic # syntax aware diffs
    fd # find alternative
    fzf # fuzzy finder
    nix-bash-completions
    ripgrep # better grep
    ripgrep-all # grep over pdfs etc
    starship # terminal prompt
    taskwarrior # CLI todo apps
    tealdeer # tldr implementation in rust, adheres to XDG basedir spec
    unstable.eza # better ls
    zellij # neotmux
    zoxide # better cd
    rmtrash # rm but to trash
    entr # file watcher - runs command on change
    # ~~~~~~~~~~~~~~~~~~ file managers {{{1 ~~~~~~~~~~~~~~~~~~ #
    # TODO choose one (or don't)
    broot
    lf
    mc
    nnn
    ranger
    vifm
    xplr
    # ~~~~~~~~~~~~~~~~~~~~~ backend {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    grpcui # postman for grpc
    grpcurl # curl for grpc
    httpie # better curl
    prettyping # better "ping"
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
    parallel # run parallel jobs
    tmux # just in case
    scc # count lines of code
    slides # markdown presentation in terminal
    peco # interactive filtering
    aria # downloader
    progress # progress status for cp etc
    pv # pipe viewer
    mprocs # job runner
    glow # markdown viewer
    libqalculate # qalc - advanced calculator
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
    unstable.xdg-ninja # checks $HOME for bloat
    python311Packages.pyicloud
    python311Packages.jupytext
    w3m # text based web browser
    wally-cli # ZSA keyboards software
    youtube-dl # download youtube videos
    fortune # random quotes
    figlet # fancy banners
    banner
    cowsay
    docker-compose
    podman-compose
    dive # look into docker image layers
    dbeaver-bin # databases
    unstable.ncspot # spotify
    # }}}
  ];
}
# vim: fdm=marker fdl=0
