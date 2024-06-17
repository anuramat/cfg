{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Browsers
    unstable.google-chrome
    unstable.firefox
    unstable.qutebrowser
    unstable.vivaldi
    unstable.vivaldi-ffmpeg-codecs # proprietary codecs TODO properly install
    tor-browser-bundle-bin

    # Terminals
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    cool-retro-term # cute terminal

    # Misc
    gnome-solanum # simple pomodoro
    gnome.cheese # webcam
    gnome.pomodoro # slightly bloated pomodoro
    hyprpicker # simple terminal color picker
    mesa-demos # some 3d demos
    # screencasting/streaming
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
      ];
    })
    qalculate-gtk # qalc calculator gui
    spotify
    steam # games
    transmission-gtk # transmission torrent client gui
  ];
}
