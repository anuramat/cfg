{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Random TODO
    transmission # torrent client
    sageWithDoc # computer algebra
    gnome-solanum # really simple one
    gnome.cheese # webcam
    gnome.pomodoro # slightly bloated
    mesa-demos # some 3d demos
    obs-studio # screencasting/streaming
    qalculate-gtk # gui for qalc
    spotify
    steam
    tor-browser-bundle-bin
    transmission-gtk # gui wrapper for transmission
    unstable.google-chrome
    unstable.obsidian # markdown personal knowledge database
    hyprpicker # gigasimple terminal color picker
  ];
}
