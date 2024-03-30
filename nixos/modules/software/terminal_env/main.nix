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

    # Code editors
    nvi
    neovim
    unstable.vis
    unstable.helix
    unstable.vim-full

    # Modern terminal
    ripgrep-all # grep over pdfs etc
    tealdeer # tldr implementation in rust, adheres to XDG basedir spec
    zoxide # better cd
    bat # better cat with syntax hl
    delta # better diffs
    fd # find alternative
    fzf # fuzzy finder
    ripgrep # better grep
    unstable.eza # better ls
    cod # completion generator (updates on `cmd --help`)
    starship # terminal prompt
    difftastic # syntax aware diffs
    lsix # ls for images (uses sixel)
    parallel # run parallel jobs
    tmux # terminal multiplexer
    zellij # ~neo-tmux
    peco # interactive filtering
    aria # downloader
    entr # file watcher - runs command on change
    taskwarrior # CLI todo apps # TODO move?

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

    # Git
    ghq # git repository manager
    git-filter-repo # rewrite/analyze repository history
    gh # GitHub CLI

    # Random useless stuff
    fortune # random quotes
    # ASCII art
    figlet
    banner
    cowsay

    # Rarely used terminal stuff
    poppler_utils # pdf utils
    ghostscript # ??? TODO
    wally-cli # ZSA keyboards software
    w3m # text based web browser
    exercism # CLI for exercism.org
    glow # markdown viewer
    youtube-dl # download youtube videos
    libqalculate # qalc - advanced calculator
    bc # simple calculator
    fastfetch # neo-neofetch
    speedtest-cli
    rclone # rsync for cloud
    age # file encryption
    nix-index
    unstable.xdg-ninja # checks $HOME for bloat
    croc # send/receive files through relay with encryption
    mosh # ssh over unstable connections
    qrcp # send files to mobile over Wi-Fi using QR
    onionshare # tor-based file-sharing etc
  ];
}
