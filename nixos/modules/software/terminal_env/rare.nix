{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
  ];
}
