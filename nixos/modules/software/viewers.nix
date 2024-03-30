{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ### Viewers
    imv # terminal image viewer
    swayimg # terminal image viewer
    nomacs # GUI image viewer

    mpv # minimalistic video player
    vlc # GUI video player

    ### Document viewers
    okular # stable gui * reader
    zathura # minimalistic ergo * reader
    djview # djvu reader
  ];
}
