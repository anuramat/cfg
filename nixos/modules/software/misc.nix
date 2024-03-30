{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Random TODO
    taskwarrior # CLI todo apps # TODO move?
    tealdeer # tldr implementation in rust, adheres to XDG basedir spec
    unstable.xdg-ninja # checks $HOME for bloat
    rclone # rsync for cloud
    starship # terminal prompt
    cod # completion generator (updates on `cmd --help`)
    age # file encryption
    speedtest-cli
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
    nix-index
  ];
}
