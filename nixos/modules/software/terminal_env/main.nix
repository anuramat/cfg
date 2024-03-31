{
  pkgs,
  unstable,
  ...
}: {
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  #   }))
  # ];
  environment.systemPackages = with pkgs; [
    # Code editors
    unstable.neovim
    nvi
    unstable.helix
    unstable.vim-full
    unstable.vis

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

    # Git
    ghq # git repository manager
    git-filter-repo # rewrite/analyze repository history
    gh # GitHub CLI

    # File managers
    xdragon # drag and drop from terminal
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
