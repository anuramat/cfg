{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    element-desktop # matrix client
    slack
    discord
    telegram-desktop
    qtox # p2p IM

    croc # send/receive files through relay with encryption
    mosh # ssh over unstable connections
    qrcp # send files to mobile over Wi-Fi using QR
    onionshare # tor-based file-sharing etc
    onionshare-gui
  ];
}
