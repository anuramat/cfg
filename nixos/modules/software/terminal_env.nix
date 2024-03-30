{
  pkgs,
  unstable,
  ...
}: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
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

    # Random system stuff
    usbutils # just in case
    libusb # user-mode USB access lib
    efibootmgr # EFI boot manager editor
    xdg-user-dirs # $HOME/* dir management

    # Code editors
    nvi
    neovim
    unstable.vis
    unstable.helix
    unstable.vim-full

    # Modern terminal
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
    ghostscript # ??? TODO
    entr # file watcher - runs command on change

    # Rarely used terminal stuff
    wally-cli # ZSA keyboards software
    w3m # text based web browser
    exercism # CLI for exercism.org
    glow # markdown viewer
    youtube-dl # download youtube videos
    libqalculate # qalc - advanced calculator
    bc # simple calculator
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
    # add more tops
    btop
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

    # Random useless stuff
    fortune # random quotes
    # ASCII art
    figlet
    banner
    cowsay
  ];
}
