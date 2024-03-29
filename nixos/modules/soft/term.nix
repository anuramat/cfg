{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Terminals
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    unstable.alacritty-theme
    cool-retro-term # cute terminal

    # Basics
    gnumake
    gcc
    bash
    killall
    coreutils-full
    coreutils-prefixed # good for mac compatibility
    curl
    git
    less
    tree
    lsof
    util-linux # was already installed but whatever
    wget
    zip
    unzip
    progress # progress status for cp etc
    nvi # vi clone
    file
    unrar-wrapper

    ### Bread and Butter
    ripgrep-all # grep over pdfs etc
    zoxide # better cd
    bat # better cat with syntax hl
    delta # better diffs
    fd # find alternative
    fzf # fuzzy finder
    ripgrep # better grep
    unstable.eza # better ls
    difftastic # syntax aware diffs
    lsix # ls for images (uses sixel)
    parallel # run parallel jobs
    tmux # terminal multiplexer
    zellij # ~neo-tmux
    peco # interactive filtering
    aria # downloader
    poppler_utils # pdf utils
    ghostscript # ???
    entr # file watcher - runs command on change

    # Random TODO
    taskwarrior # CLI todo apps # TODO move?
    tealdeer # tldr implementation in rust, adheres to XDG basedir spec
    unstable.xdg-ninja # checks $HOME for bloat
    rclone # rsync for cloud
    starship # terminal prompt
    cod # completion generator (updates on `cmd --help`)
    age # file encryption
    speedtest-cli
    nix-index

    ### Rarely used terminal stuff
    wally-cli # ZSA keyboards software
    w3m # text based web browser
    exercism # CLI for exercism.org
    glow # markdown viewer
    youtube-dl # download youtube videos
    wtf # TUI dashboard
    libqalculate # qalc - advanced calculator
    bc # simple calculator
    neofetch
    fastfetch

    # Web
    grpcui # postman for grpc
    grpcurl # curl for grpc
    httpie # better curl
    prettyping # better "ping"
    kubectx
    kubectl

    # Completion # TODO check if this is even used
    bash-completion
    nix-bash-completions

    # File managers
    xdragon
    # TODO choose one
    vifm
    mc
    ranger
    lf
    nnn
    broot
    xplr

    # Monitoring
    htop # better top
    atop # even better top
    ctop # container top
    nvtop # top for GPUs
    duf # disk usage (better "df")
    du-dust # directory disk usage (better du)
    ncdu # directory sidk usage (better du)
    acpi # battery status etc

    # Git
    ghq # git repository manager
    git-filter-repo # rewrite/analyze repository history
    gh # GitHub CLI

    # Networking
    wirelesstools # iwconfig etc
    dig # dns utils
    inetutils # common network stuff
    nmap
    netcat

    # Random linux shit TODO
    usbutils # just in case
    libusb # user-mode USB access lib
    efibootmgr # EFI boot manager editor
    fortune
    # ascii art
    figlet 
    banner
    cowsay
  ];
}
