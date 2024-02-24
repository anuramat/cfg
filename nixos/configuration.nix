# > man 5 configuration.nix
# > nixos help

{ config, pkgs, lib, ... }:

let
  username = "anuramat";
  fullname = "Arsen Nuramatov";
  hostname = "anuramat-t480";
  timezone = "Etc/GMT-6";
  stateVersion = "23.05"; # WARNING DO NOT EDIT

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Sway boilerplate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
  pythonPackages = ps: with ps; [
  ];
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  # ~~~~~~~~~~~~~~~~~~~~~~~ NixOS stuff ~~~~~~~~~~~~~~~~~~~~~~~~
  system =
    {
      # backup the configuration.nix to /run/current-system/configuration.nix
      copySystemConfiguration = true;
      stateVersion = stateVersion;
    };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
    allowUnfree = true;
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~ Basics ~~~~~~~~~~~~~~~~~~~~~~~~~~
  time.timeZone = timezone; # WARN inverted
  i18n.defaultLocale = "en_US.UTF-8";
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~ User ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # TODO: icons, cursor
  users.users.${username} = {
    description = fullname;
    isNormalUser = true;
    extraGroups = [
      "wheel" # root
      "video" # screen brightness
      "network" # wifi
      "docker" # docker
      "audio" # just in case (?)
      "syncthing" # just in case default syncthing settings are used
      "plugdev" # pluggable devices : required by zsa voyager
      "input" # le unsecure, used by waybar-keyboard-state
      "dialout" # serial ports
    ];
    packages = with pkgs; [
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
      sway-contrib.inactive-windows-transparency
      dbus-sway-environment
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
  environment =
    {
      shellAliases = {
        l = null;
      };
      systemPackages = with pkgs; [
        ### Terminals
        foot # minimal terminal
        unstable.alacritty # gpu terminal
        unstable.alacritty-theme
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
        rclone # rsync for cloud

        ### Media
        gimp-with-plugins # raster graphics
        # krita # raster graphics, digital art
        # inkscape-with-extensions # vector graphics
        # davinci-resolve

        ### Comms
        element-desktop # matrix client
        slack
        discord
        telegram-desktop

        ### Random
        obs-studio # screencasting/streaming
        onionshare # tor-based file-sharing etc
        onionshare-gui
        qtox # p2p IM
        sageWithDoc # computer algebra
        hyprpicker # gigasimple terminal color picker
        steam

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

        ### Languages
        #### Compilers/interpreters
        go
        nodejs_20
        yarn
        ruby
        perl
        llvm
        clang
        python3
        unstable.stack
        #### Language tooling
        unstable.cabal-install
        universal-ctags # maintained ctags
        jq # json processor
        bats # Bash testing
        bear # Compilation database generator for clangd
        black # Python formatter
        delve # Go debugger
        gofumpt # strict go formatter
        golangci-lint # gigalinter for go
        luajitPackages.luacheck
        luajitPackages.luarocks
        bash-completion
        micromamba # conda rewrite in C++
        nixpkgs-fmt # nix formatter
        nodePackages.prettier # formatting
        shellcheck # *sh linter
        shfmt # posix/bash/mksh formatter
        stylua # Lua formatter
        nix-bash-completions
        yamlfmt # YAML formatter
        #### LSPs
        nodePackages_latest.bash-language-server
        nodePackages_latest.yaml-language-server
        lua-language-server
        unstable.texlab
        unstable.haskell-language-server
        unstable.nixd
        unstable.pyright
        unstable.gopls
        unstable.marksman

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
        handbrake # ghb - GUI for video converting
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
        unstable.vim
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
        ghostscript # ???
        entr # file watcher - runs command on change

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

        ### Random stuff TODO
        mesa-demos # some 3d demos
        neovide # neovim gui
        nix-index

        ### Web browsers
        google-chrome

        ### Screenshots and screen capture
        slurp # select screen region
        grim # CLI screenshot
        shotman # screenshot, with simple preview afterwards, no markup
        swappy # markup wrapper for grim+slurp/etc
        wf-recorder # CLI screen capture
        kooha # screen capture with basic gui

        ### DE stuff
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
        swayidle # idle events
        swaylock # lockscreen
        pavucontrol # gui audio configuration
        sov # workspace overview for sway

        ### Display settings
        # TODO Choose one
        wdisplays # gui display configuration
        kanshi
        wlopm
        wlr-randr

        brightnessctl

        ### Themes etc
        glib # gsettings (gtk etc)
        qt5ct # qt5 gui settings
        qt6ct # qt6 gui settings
        adwaita-qt
        dracula-theme
        dracula-icon-theme
        hackneyed
        gnome3.adwaita-icon-theme

        ### Sway scripts defined in this file
      ];
    };
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
  # TODO restic backups
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  documentation.man.generateCaches = true; # apropos
  virtualisation.docker.enable = true;
  services.syncthing =
    {
      enable = true;
      user = username;
      dataDir = "/home/${username}"; # parent directory for synchronised folders
      configDir = "/home/${username}/.config/syncthing"; # keys and settings
      databaseDir = "/home/${username}/.local/share/syncthing"; # database and logs
    };
}
