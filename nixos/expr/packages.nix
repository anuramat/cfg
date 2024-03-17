pkgs: unstable: with pkgs; [
  ### Terminals
  foot # minimal terminal
  unstable.alacritty # gpu terminal
  unstable.alacritty-theme
  cool-retro-term # cute terminal

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
  vlc # gui video player
  rclone # rsync for cloud
  starship # terminal prompt
  cod # completion generator (updates on `cmd --help`)
  tldr # local cheatsheets
  age # file encryption

  ### Media
  gimp-with-plugins # raster graphics
  # krita # raster graphics, digital art
  # inkscape-with-extensions # vector graphics
  # davinci-resolve

  ### Comms
  element-desktop # matrix client
  slack
  discord
  telegram-desktop

  ### Random
  obs-studio # screencasting/streaming
  onionshare # tor-based file-sharing etc
  onionshare-gui
  qtox # p2p IM
  sageWithDoc # computer algebra
  hyprpicker # gigasimple terminal color picker
  steam

  ### Barebones
  gnumake
  gcc
  bash
  killall
  coreutils-full
  coreutils-prefixed # to keep mac compatibility where possible
  curl
  git
  less
  lsof
  wget
  zip
  unzip
  progress # progress status for cp etc
  nvi # vi clone
  usbutils # just in case
  file

  ### File managers
  xdragon
  # TODO choose one
  vifm
  mc
  ranger
  lf
  nnn
  broot
  xplr

  # vscode

  ### Languages
  #### Compilers/interpreters
  go
  nodejs_20
  yarn
  ruby
  perl
  llvm
  clang
  python3
  unstable.stack
  #### Language tooling
  unstable.cabal-install
  universal-ctags # maintained ctags
  jq # json processor
  yq # basic yaml, json, xml, csv, toml processor
  bats # Bash testing
  bear # Compilation database generator for clangd
  black # Python formatter
  delve # Go debugger
  gofumpt # strict go formatter
  golangci-lint # gigalinter for go
  luajitPackages.luacheck
  luajitPackages.luarocks
  bash-completion
  micromamba # conda rewrite in C++
  nixpkgs-fmt # nix formatter
  nodePackages.prettier # formatting
  shellcheck # *sh linter
  shfmt # posix/bash/mksh formatter
  stylua # Lua formatter
  nix-bash-completions
  yamlfmt # YAML formatter
  #### LSPs
  nodePackages_latest.bash-language-server
  nodePackages_latest.yaml-language-server
  lua-language-server
  unstable.texlab
  unstable.haskell-language-server
  unstable.nixd
  unstable.pyright
  unstable.gopls
  unstable.marksman

  ### Viewers
  imv # terminal image viewer
  swayimg # terminal image viewer
  nomacs # GUI image viewer
  mpv # cli video player
  ### Document viewers
  okular # GUI * reader
  zathura # vimmy * reader
  djview # GUI djvu reader

  ### Media tools
  easyocr # neural OCR
  ffmpeg # CLI multimedia processing
  handbrake # ghb - GUI for video converting
  pandoc # markup converter (latex, markdown, etc)
  sox # CLI audio processing
  imagemagickBig # CLI image manipulation
  libwebp # tools for WebP image format
  exiftool # read/write EXIF metadata
  djvulibre # djvu tools

  ### Web shit
  grpcui # postman for grpc
  grpcurl # curl for grpc
  httpie # better curl
  prettyping # better "ping"
  kubectx
  kubectl

  ### Monitoring
  htop # better top
  atop # even better top
  ctop # container top
  nvtop # top for GPUs
  duf # disk usage (better "df")
  du-dust # directory disk usage (better du)
  ncdu # directory sidk usage (better du)

  ### Git
  ghq # git repository manager
  git-filter-repo # rewrite/analyze repository history
  gh # GitHub CLI

  ### Networking
  wirelesstools # iwconfig etc
  dig # dns utils
  inetutils # common network stuff
  nmap
  netcat

  ### Random linux shit
  libusb # user-mode USB access lib
  efibootmgr # EFI boot manager editor
  acpi # battery status etc

  ### Basic terminal stuff
  unstable.vim
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
  croc # send/receive files
  w3m # text based web browser
  qrcp # send files to mobile over Wi-Fi using QR
  exercism # CLI for exercism.org
  glow # markdown viewer
  youtube-dl # download youtube videos
  wtf # TUI dashboard
  libqalculate # qalc - advanced calculator
  bc # simple calculator
  neofetch
  fastfetch
  mosh # ssh over unstable connections

  ### Random stuff TODO
  mesa-demos # some 3d demos
  unstable.neovide # neovim gui
  nix-index

  ### Web browsers
  google-chrome

  ### Screenshots and screen capture
  slurp # select screen region
  grim # CLI screenshot
  shotman # screenshot, with simple preview afterwards, no markup
  swappy # markup wrapper for grim+slurp/etc
  wf-recorder # CLI screen capture
  kooha # screen capture with basic gui

  ### DE stuff
  networkmanagerapplet
  waybar # status bar
  tofi # app launcher
  wev # wayland event viewer, useful for debugging
  libnotify # notify-send etc
  mako # notifications
  xdg-utils # xdg-open etc
  desktop-file-utils # update-desktop-database etc
  xdg-ninja # checks $HOME for bloat
  wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout
  playerctl # cli media player controls
  swaybg # wallpaper helper
  mpvpaper # video wallpaper helper
  glpaper # shader wallpaper
  swaylock-effects # lockscreen, swaylock fork
  swayidle # idle events
  pavucontrol # gui audio configuration
  sov # workspace overview for sway

  ### Display settings
  # TODO Choose one
  wdisplays # gui display configuration
  kanshi
  wlopm
  wlr-randr

  brightnessctl

  ### Themes etc
  glib # gsettings (gtk etc)
  qt5ct # qt5 gui settings
  qt6ct # qt6 gui settings
  adwaita-qt
  dracula-theme
  dracula-icon-theme
  hackneyed
  gnome3.adwaita-icon-theme
]
