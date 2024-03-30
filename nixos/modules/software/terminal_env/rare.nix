{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    croc # send/receive files through relay with encryption
    exercism # CLI for exercism.org
    fastfetch # neo-neofetch
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
