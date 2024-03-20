pkgs: unstable:
with pkgs; [
  ### Random
  cinnamon.nemo # wayland native
  gnome-solanum # really simple one
  gnome.cheese # webcam
  gnome.pomodoro # slightly bloated
  qalculate-gtk # gui for qalc
  spotify
  tor-browser-bundle-bin
  transmission # torrent client
  transmission-gtk # gui wrapper for transmission
  unstable.obsidian # markdown personal knowledge database
  xdg-ninja # checks $HOME for bloat
  rclone # rsync for cloud
  starship # terminal prompt
  cod # completion generator (updates on `cmd --help`)
  tealdeer # tldr implementation in rust, adheres to XDG basedir spec
  age # file encryption
  speedtest-cli
  obs-studio # screencasting/streaming
  sageWithDoc # computer algebra
  hyprpicker # gigasimple terminal color picker
  steam
  unstable.vscode

  ### Basic terminal stuff
  unstable.vim-full
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
  peco # interactive filtering
  aria # downloader
  poppler_utils # pdf utils
  ghostscript # ???
  entr # file watcher - runs command on change

  ### Terminal apps
  taskwarrior # CLI todo apps

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

  ### Random stuff TODO
  mesa-demos # some 3d demos
  unstable.neovide # neovim gui
  nix-index
  unstable.neovim
]
