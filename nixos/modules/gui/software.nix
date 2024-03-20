let
  unstable = import <nixos-unstable> {inherit (config.nixpkgs) config;};
in
  {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      unstable.avizo # brightness/volume control with overlay indicator
      google-chrome
      system-config-printer # printer gui
      networkmanagerapplet
      waybar # status bar
      tofi # app launcher
      wev # wayland event viewer, useful for debugging
      libnotify # notify-send etc
      mako # notifications
      xdg-utils # xdg-open etc
      desktop-file-utils # update-desktop-database etc
      xdg-ninja # checks $HOME for bloat
      wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout
      playerctl # cli media player controls
      swaybg # wallpaper helper
      mpvpaper # video wallpaper helper
      glpaper # shader wallpaper
      swaylock-effects # lockscreen, swaylock fork
      swayidle # idle events
      pavucontrol # gui audio configuration
      sov # workspace overview for sway

      ### Display settings
      kanshi # plaintext defined display configs
      wlr-randr # interactive cli display configs
      wlay # gui display configs (can output kanshi/sway/wlr-randr files)
      ### Screenshots and screen capture
      slurp # select screen region
      grim # CLI screenshot
      shotman # screenshot, with simple preview afterwards, no markup
      swappy # markup wrapper for grim+slurp/etc
      wf-recorder # CLI screen capture
      kooha # screen capture with basic gui
    ];
  }
