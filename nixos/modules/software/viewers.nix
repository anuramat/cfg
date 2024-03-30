{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Images
    # TODO find the best??
    imv # terminal image viewer
    swayimg # terminal image viewer
    nomacs # GUI image viewer

    # Video
    mpv # minimalistic video player
    vlc # GUI video player

    # Documents
    okular
    zathura # keyboard-centric
    djview # djvu reader
  ];
}
