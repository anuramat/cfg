{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Code editors
    unstable.emacs-gtk
    neovim
    nvi
    unstable.helix
    unstable.vis

    # some random goodies
    unstable.ncspot # spotify

    # Modern terminal
    bash-completion
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

    # Git
    ghq # git repository manager
    git-filter-repo # rewrite/analyze repository history
    gh # GitHub CLI

    # Building and shit
    unstable.devenv
    distrobox

    # File managers
    # TODO choose one or don't
    broot
    lf
    mc
    nnn
    ranger
    vifm
    xplr
  ];
}
