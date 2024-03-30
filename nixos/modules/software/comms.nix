{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    element-desktop # matrix client
    slack
    discord
    telegram-desktop
    qtox # p2p IM
    onionshare-gui
  ];
}
