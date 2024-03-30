{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome-solanum # really simple one
    gnome.cheese # webcam
    gnome.pomodoro # slightly bloated
    hyprpicker # gigasimple terminal color picker
    mesa-demos # some 3d demos
    obs-studio # screencasting/streaming
    qalculate-gtk # gui for qalc
    sageWithDoc # computer algebra
    spotify
    steam
    tor-browser-bundle-bin
    transmission # torrent client
    transmission-gtk # gui wrapper for transmission
    unstable.google-chrome
    unstable.obsidian # markdown personal knowledge database
  ];
}
