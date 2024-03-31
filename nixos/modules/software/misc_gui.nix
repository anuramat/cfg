{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome-solanum # simple pomodoro
    gnome.cheese # webcam
    gnome.pomodoro # slightly bloated pomodoro
    hyprpicker # gigasimple terminal color picker
    mesa-demos # some 3d demos
    obs-studio # screencasting/streaming
    qalculate-gtk # gui for qalc
    sageWithDoc # computer algebra system
    spotify
    steam
    tor-browser-bundle-bin
    helvum # pipewire patchbay
    transmission # torrent client
    transmission-gtk # gui wrapper for transmission
    unstable.google-chrome
    unstable.obsidian # markdown personal knowledge database
  ];
}
