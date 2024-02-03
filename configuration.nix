# > man 5 configuration.nix
# > nixos help

{ config, pkgs, lib, ... }:

let
  username = "anuramat";
  fullname = "Arsen Nuramatov";
  hostname = "anuramat-t480";
  timezone = "Etc/GMT-6";
  version = "23.05";
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Sway boilerplate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # https://nixos.wiki/wiki/Sway
  transparent-inactive = pkgs.writeTextFile {
    name = "transparent-inactive";
    destination = "/bin/transparent-inactive";
    executable = true;
    text = ''
      #!/usr/bin/env python
      import i3ipc
      transparency_val = '0.8';
      ipc              = i3ipc.Connection()
      prev_focused     = None
      for window in ipc.get_tree():
          if window.focused:
              prev_focused = window
          else:
              window.command('opacity ' + transparency_val)
      def on_window_focus(ipc, focused):
          global prev_focused
          if focused.container.id != prev_focused.id: # https://github.com/swaywm/sway/issues/2859
              focused.container.command('opacity 1')
              prev_focused.command('opacity ' + transparency_val)
              prev_focused = focused.container
      ipc.on("window::focus", on_window_focus)
      ipc.main()
    '';
  };
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema color-scheme 'prefer-dark'
      '';
  };
  pythonPackages = ps: with ps; [
    i3ipc
  ];
  home-manager =
    fetchTarball
      "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";

  unstableTarball =
    fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
in
{
  # ~~~~~~~~~~~~~~~~~~~~~~~ NixOS stuff ~~~~~~~~~~~~~~~~~~~~~~~~
  system =
    {
      # backup the configuration.nix to /run/current-system/configuration.nix
      copySystemConfiguration = true;
      # determines default settings for stateful data
      stateVersion = version; # WARN: DON'T TOUCH
    };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];
  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~ Basics ~~~~~~~~~~~~~~~~~~~~~~~~~~
  time.timeZone = timezone; # WARN inverted
  i18n.defaultLocale = "en_US.UTF-8";
  # TODO what does this even do
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~ User ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # home-manager.users.${username} = {
  #   # gtk = { # writes a symlink to .config/gtk-3.0, no thanks
  #   #   enable = true;
  #   #   theme = {
  #   #     package = pkgs.dracula-theme;
  #   #     name = "Dracula";
  #   #   };
  #   #   iconTheme = {
  #   #     package = pkgs.dracula-icon-theme;
  #   #     name = "Dracula";
  #   #   };
  #   #   cursorTheme = null; # probably overlap with pointerCursor
  #   # };
  #   home = {
  #     stateVersion = version;
  #     pointerCursor = {
  #       name = "Adwaita";
  #       package = pkgs.gnome.adwaita-icon-theme;
  #       size = 24;
  #       gtk.enable = true;
  #       x11 = {
  #         enable = true;
  #         defaultCursor = "Adwaita";
  #       };
  #     };
  #   };
  # };

  users.users.${username} = {
    description = fullname;
    isNormalUser = true;
    extraGroups = [
      "wheel" # root
      "video" # screen brightess
      "network" # wifi
      "docker" # docker
      "audio" # just in case (?)
      "syncthing" # just in case default syncthing settings are used
      "plugdev" # pluggable devices : required by zsa voyager
      "input" # le unsecure, used by waybar-keyboard-state
      "dialout" # serial ports
    ];
    packages = with pkgs; [
      ### Terminals
      foot # minimal terminal
      alacritty # gpu terminal
      cool-retro-term # cute terminal

      ### Random
      cinnamon.nemo # wayland native
      gnome-solanum # really simple one
      gnome.cheese # webcam
      gnome.pomodoro # slightly bloated
      qalculate-gtk # gui for qalc
      spotify
      tor-browser-bundle-bin
      transmission # torrent client
      transmission-gtk # gui wrapper for transmission
      unstable.obsidian # markdown personal knowledge database
      vlc # gui video player

      ### Media
      gimp-with-plugins # raster graphics
      # krita # raster graphics, digital art
      # inkscape-with-extensions # vector graphics
      # davinci-resolve

      ### Social
      element-desktop # matrix client
      slack
      discord
      telegram-desktop


      ### Random rare
      obs-studio # screencasting/streaming
      onionshare # tor-based file-sharing etc
      onionshare-gui
      qtox # p2p IM
      sageWithDoc # computer algebra
      steam
      hyprpicker # gigasimple terminal color picker
    ];
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~ Misc GUI ~~~~~~~~~~~~~~~~~~~~~~~~~
  fonts.packages = with pkgs; [
    nerdfonts
  ];
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~ Networking ~~~~~~~~~~~~~~~~~~~~~~~~
  # TODO why set nameservers twice?
  networking =
    {
      firewall.enable = true;
      # firewall.allowedTCPPorts = [ ... ];
      # firewall.allowedUDPPorts = [ ... ];
      networkmanager = {
        enable = true; # TODO find a decent gui?;
        #   wifi.backend = "iwd";
        # };
        # wireless.iwd = {
        #   enable = true;
        #   settings = { Settings = { AutoConnect = true; }; };
      };
      hostName = hostname;
      nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ]; # Set cloudflare dns TODO what does #one.one.one.one mean
    };
  # uses DNSSEC and DNSoverTLS, might break on a different ns
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~ Printers ~~~~~~~~~~~~~~~~~~~~~~~~~~
  services = {
    # Enable CUPS to print documents, available @ http://localhost:631/
    printing = {
      enable = true;
      # drivers = [ YOUR_DRIVER ];
    };
    # Implementation for Multicast DNS aka Zeroconf aka Apple Rendezvous aka Apple Bonjour
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true; # Open udp 5353 for network devices discovery
    };
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~ Power ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  services = {
    thermald.enable = true; # cooling
    tlp.enable = true; # voltage, wifi/bluetooth cli switches
    upower.enable = true; # suspend on low battery
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~ Bluetooth ~~~~~~~~~~~~~~~~~~~~~~~~~
  hardware.bluetooth =
    {
      enable = true;
      powerOnBoot = true;
    };
  services.blueman.enable = true; # bluetooth
  # ~~~~~~~~~~~~~~~~~~~~~~~ Special keys ~~~~~~~~~~~~~~~~~~~~~~~
  services.logind.extraConfig = ''
    HandlePowerKey=hybrid-sleep
    HandlePowerKeyLongPress=ignore
    HandleSuspendKey=suspend
    HandleHibernateKey=suspend
    HandleLidSwitch=suspend
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=ignore
  '';
  programs.light.enable = true; # Brightness control
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~ Sound ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # https://nixos.wiki/wiki/PipeWire
  services.pipewire = {
    # TODO some of these aren't needed probably
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # "sound.enable is only meant for ALSA-based configurations"
  sound.enable = false;
  # RealtimeKit, scheduling priotity of user processes, used eg by PulseAudio to get realtime priority
  # "optional but recommended"
  security.rtkit.enable = true;
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~ Sway ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      autotiling
      transparent-inactive
    ];
  };
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = [ "google-chrome.desktop" ];
        "x-scheme-handler/https" = [ "google-chrome.desktop" ];
        "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
        "x-scheme-handler/vscode" = [ "code-url-handler.desktop" ];

        "text/plain" = [ "nvim.desktop" ];
        "text/english" = [ "nvim.desktop" ];
        "text/x-makefile" = [ "nvim.desktop" ];
        "text/x-c++hdr" = [ "nvim.desktop" ];
        "text/x-c++src" = [ "nvim.desktop" ];
        "text/x-chdr" = [ "nvim.desktop" ];
        "text/x-csrc" = [ "nvim.desktop" ];
        "text/x-java" = [ "nvim.desktop" ];
        "text/x-moc" = [ "nvim.desktop" ];
        "text/x-pascal" = [ "nvim.desktop" ];
        "text/x-tcl" = [ "nvim.desktop" ];
        "text/x-tex" = [ "nvim.desktop" ];
        "application/x-shellscript" = [ "nvim.desktop" ];
        "text/x-c" = [ "nvim.desktop" ];
        "text/x-c++" = [ "nvim.desktop" ];

        "inode/directory" = [ "nnn.desktop" ];


        "image/gif" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/jpeg" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/png" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/bmp" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/tiff" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/x-eps" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/x-ico" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/x-portable-bitmap" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/x-portable-graymap" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/x-portable-pixmap" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/x-xbitmap" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/x-xpixmap" = [ "org.nomacs.ImageLounge.desktop" ];
      };
    };
  };
  services.dbus.enable = true;
  # ~~~~~~~~~~~~~~~~~~~~~ System software ~~~~~~~~~~~~~~~~~~~~~~
  environment.systemPackages = with pkgs; [
    ### Barebones
    gnumake
    gcc
    bash
    killall
    coreutils-full
    coreutils-prefixed # to keep mac compatibility where possible
    curl
    git
    less
    lsof
    wget
    zip
    unzip
    progress # progress status for cp etc
    nvi # vi clone
    usbutils # just in case
    file

    ### File managers
    xdragon
    # TODO choose one
    vifm
    mc
    ranger
    lf
    nnn
    broot
    xplr

    ### Languages support
    go
    nodejs_20
    yarn
    ruby
    perl
    llvm
    clang
    (python3.withPackages pythonPackages)

    ### Language tooling
    universal-ctags # maintained ctags
    jq # json processor
    bats # Bash testing
    bear # Compilation database generator for clangd
    black # Python formatter
    delve # Go debugger
    gofumpt # strict go formatter
    golangci-lint # gigalinter for go
    gopls # Go LSP
    lua-language-server
    luajitPackages.luacheck
    luajitPackages.luarocks
    bash-completion
    marksman # markdown LSP
    micromamba # conda rewrite in C++
    nixpkgs-fmt # nix formatter
    nodePackages.prettier # formatting
    nodePackages_latest.bash-language-server
    nodePackages_latest.yaml-language-server
    pyright # Python LSP
    shellcheck # *sh linter
    shfmt # posix/bash/mksh formatter
    stylua # Lua formatter
    unstable.nixd # nix LSP
    nix-bash-completions
    yamlfmt # YAML formatter

    ### Viewers
    imv # terminal image viewer
    swayimg # terminal image viewer
    nomacs # GUI image viewer
    mpv # cli video player
    ### Document viewers
    okular # GUI * reader
    zathura # vimmy * reader
    djview # GUI djvu reader

    ### Media tools
    easyocr # neural OCR
    ffmpeg # CLI multimedia processing
    pandoc # markup converter (latex, markdown, etc)
    sox # CLI audio processing
    imagemagickBig # CLI image manipulation
    libwebp # tools for WebP image format
    exiftool # read/write EXIF metadata
    djvulibre # djvu tools

    ### Web shit
    grpcui # postman for grpc
    grpcurl # curl for grpc
    httpie # better curl
    prettyping # better "ping"
    kubectx
    kubectl

    ### Monitoring
    htop # better top
    atop # even better top
    ctop # container top
    nvtop # top for GPUs
    duf # disk usage (better "df")
    du-dust # directory disk usage (better du)
    ncdu # directory sidk usage (better du)

    ### Git
    ghq # git repository manager
    git-filter-repo # rewrite/analyze repository history
    gh # GitHub CLI

    ### Networking
    wirelesstools # iwconfig etc
    dig # dns utils
    inetutils # common network stuff
    nmap
    netcat

    ### Random linux shit
    libusb # user-mode USB access lib
    efibootmgr # EFI boot manager editor
    acpi # battery status etc

    ### Basic terminal stuff
    unstable.neovim
    ripgrep-all # grep over pdfs etc
    zoxide # better cd
    bat # better cat with syntax hl
    delta # better diffs
    fd # find alternative
    fzf # fuzzy finder
    ripgrep # better grep
    unstable.eza # better ls
    difftastic # syntax aware diffs
    lsix # ls for images (uses sixel)
    parallel # run parallel jobs
    tmux # terminal multiplexer
    peco # interactive filtering
    aria # downloader
    poppler_utils # pdf utils
    ghostscript

    ### Terminal apps
    taskwarrior # CLI todo apps

    ### Rarely used terminal stuff
    wally-cli # ZSA keyboards software
    croc # send/receive files
    w3m # text based web browser
    qrcp # send files to mobile over Wi-Fi using QR
    exercism # CLI for exercism.org
    glow # markdown viewer
    youtube-dl # download youtube videos
    wtf # TUI dashboard
    libqalculate # qalc - advanced calculator
    bc # simple calculator
    neofetch
    mosh # ssh over unstable connections


    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ We got this far ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    mesa-demos
    google-chrome
    vscode
    ### Screenshots and screen capture
    slurp # select screen region
    grim # CLI screenshot
    shotman # screenshot, with simple preview afterwards, no markup
    swappy # markup wrapper for grim+slurp/etc
    wf-recorder # CLI screen capture
    kooha # screen capture with basic gui
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    waybar # status bar
    wev # wayland event viewer
    libnotify # notify-send etc
    mako # notifications
    xdg-utils # xdg-open etc
    desktop-file-utils # update-desktop-database etc
    xdg-ninja # checks $HOME for bloat
    wl-clipboard # wl-copy/wl-paste: copy from stdin/paste to stdout
    playerctl # cli media player controls
    swaybg # wallpaper helper
    mpvpaper # video wallpaper helper
    swayidle # idle events
    swaylock # lockscreen
    # ~~~~~~~~~~~~~~~~~~~~~ display settings ~~~~~~~~~~~~~~~~~~~~~
    # TODO Choose one
    wdisplays # gui display configuration
    kanshi
    wlopm
    wlr-randr
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    tofi # app launcher
    pavucontrol # gui audio configuration
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~ Themes ~~~~~~~~~~~~~~~~~~~~~~~~~~
    glib # gsettings (gtk etc)
    qt5ct
    unstable.qt6ct
    adwaita-qt
    adwaita-qt6
    dracula-theme
    dracula-icon-theme
    gnome3.adwaita-icon-theme
    # ~~~~~~~~~~~~~~~~~~~~~~~ Sway scripts ~~~~~~~~~~~~~~~~~~~~~~~
    dbus-sway-environment
    configure-gtk
  ];
  # ~~~~~~~~~~~~~~~~~~~~~~~~~ Hardware ~~~~~~~~~~~~~~~~~~~~~~~~~
  # ZSA Voyager
  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
  '';
  # Flipper Zero
  hardware.flipperzero.enable = true;
  # Removable media
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
  # ~~~~~~~~~~~~~~~~~~~~~~ Misc software ~~~~~~~~~~~~~~~~~~~~~~~
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  documentation.man.generateCaches = true; # apropos
  virtualisation.docker.enable = true;
  services.syncthing =
    {
      # NOTE this is a mess, everything is stored in .config, for now will have to ignore all of it in cfg repo
      # use XDG paths when transitioning to home manager
      enable = true;
      user = username;
      dataDir = "/home/anuramat"; # parent directory for folders declared with nix
      configDir = "/home/${username}/.config/syncthing"; # keys, database, configuration
      extraFlags = [
        # "--config=/home/${username}/.config/syncthing" # keys and configuration
        # "--data=/home/${username}/.local/share/syncthing" # where to store the database files
      ];
    };
}
