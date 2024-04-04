{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    entr # file watcher - runs command on change
    lsix # ls for images (uses sixel)
    parallel # run parallel jobs
    tmux # just in case
    slides # markdown presentation in terminal
    peco # interactive filtering
    aria # downloader
    progress # progress status for cp etc
    pv # pipe viewer
    glow # markdown viewer
    libqalculate # qalc - advanced calculator
    age # file encryption
    croc # send/receive files through relay with encryption
    fastfetch # neo-neofetch
    exercism # CLI for exercism.org
    ghostscript # ??? TODO
    mosh # ssh over unstable connections
    nix-index
    onionshare # tor-based file-sharing etc
    poppler_utils # pdf utils
    qrcp # send files to mobile over Wi-Fi using QR
    rclone # rsync for cloud
    speedtest-cli
    unstable.xdg-ninja # checks $HOME for bloat
    w3m # text based web browser
    wally-cli # ZSA keyboards software
    youtube-dl # download youtube videos
    fortune # random quotes
    figlet # fancy banners
    banner
    cowsay
  ];
}
