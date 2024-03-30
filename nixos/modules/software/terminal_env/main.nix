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
    zellij # neotmux
    entr # file watcher - runs command on change
    taskwarrior # CLI todo apps
    bash-completion
    nix-bash-completions
    lsix # ls for images (uses sixel)
    parallel # run parallel jobs
    tmux # just in case
    peco # interactive filtering
    aria # downloader
    progress # progress status for cp etc
    glow # markdown viewer
    libqalculate # qalc - advanced calculator
    age # file encryption

    # Git
    ghq # git repository manager
    git-filter-repo # rewrite/analyze repository history
    gh # GitHub CLI

    # File managers
    xdragon
    # TODO choose one or don't
    vifm
    mc
    ranger
    lf
    nnn
    broot
    xplr
  ];
}
