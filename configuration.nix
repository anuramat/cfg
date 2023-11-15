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

  home-manager =
    fetchTarball
      "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";

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
      "electron-24.8.6"
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
  home-manager.users.${username} = {
    # gtk = { # writes a symlink to .config/gtk-3.0, no thanks
    #   enable = true;
    #   theme = {
    #     package = pkgs.dracula-theme;
    #     name = "Dracula";
    #   };
    #   iconTheme = {
    #     package = pkgs.dracula-icon-theme;
    #     name = "Dracula";
    #   };
    #   cursorTheme = null; # probably overlap with pointerCursor
    # };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "neovim.desktop" ];
      };
    };
    home = {
      stateVersion = version;
      pointerCursor = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
        size = 24;
        gtk.enable = true;
        x11 = {
          enable = true;
          defaultCursor = "Adwaita";
        };
      };
    };
  };

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
    ];
    packages = with pkgs; [
      unstable.eza
      unstable.nixd
      # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CLI ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      qrcp # send files to mobile over Wi-Fi using QR
      exercism # CLI for exercism.org
      ripgrep-all # grep over pdfs etc
      zoxide # better cd
      difftastic # syntax aware diffs
      # ~~~~~~~~~~~~~~~~~~~~~~ File managers ~~~~~~~~~~~~~~~~~~~~~~~
      # TODO choose one?
      vifm
      mc
      xdragon
      ranger
      lf
      nnn
      broot
      xplr
      # ~~~~~~~~~~~~~~~~~~~~~~~~ Languages ~~~~~~~~~~~~~~~~~~~~~~~~~
      nodejs_20
      yarn
      ruby
      perl
      # ~~~~~~~~~~~~~~~~~~~~~ Language support ~~~~~~~~~~~~~~~~~~~~~
      micromamba # conda rewrite in C++
      gopls # Go LSP
      bats # Bash testing
      nodePackages_latest.bash-language-server
      yamlfmt # YAML formatter
      bear # Compilation database generator for clangd
      black # Python formatter
      delve # Go debugger
      gofumpt # strict go formatter
      golangci-lint # gigalinter for go
      pyright # Python LSP
      shellcheck # *sh linter
      shfmt # posix/bash/mksh formatter
      stylua # Lua formatter
      lua-language-server
      luajitPackages.luacheck
      luajitPackages.luarocks
      marksman # markdown LSP
      # ~~~~~~~~~~~~~~~~~~~~~~~~ Disk usage ~~~~~~~~~~~~~~~~~~~~~~~~
      duf # disk usage (better "df")
      du-dust # directory disk usage (better du)
      ncdu # directory sidk usage (better du)
      # ~~~~~~~~~~~~~~~~~~~~~~ Image viewers ~~~~~~~~~~~~~~~~~~~~~~~
      imv
      swayimg
      vimiv-qt
      nomacs # GUI
      # ~~~~~~~~~~~~~~~~~~~~~~~ Swiss tools ~~~~~~~~~~~~~~~~~~~~~~~~
      ffmpeg # video
      pandoc # markup (latex, markdown, etc)
      sox # audio
      imagemagickBig # images NOTE I don't know what "Big" means, might as well just use "imagemagick"
      # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      git-filter-repo # rewrite/analyze repository history
      grpcui # postman for grpc
      grpcurl # curl for grpc
      htop # better top
      atop # even better top
      ctop # container top
      httpie # better curl
      kubectx
      kubectl
      # emacs-gtk
      lazydocker
      lazygit
      llvm
      netcat
      nmap
      glow # markdown viewer
      nvi # vi clone
      parallel
      peco # interactive filtering
      prettyping # better "ping"
      tmux
      tree # prefer "exa --tree" instead
      universal-ctags
      youtube-dl
      nodePackages_latest.yaml-language-server
      taskwarrior # TODO todos
      ghq # git repository manager
      gh # GitHub CLI
      lsix # ls for images (sixel)
      nvtop # top for GPUs
      wtf # dashboard
      libqalculate # qalc - advanced calculator
      aria # downloader
      hyprpicker # gigasimple terminal color picker
      neofetch
      mosh
      # ~~~~~~~~~~~~~~~~~~~~~~~~~~~ GUI ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      cinnamon.nemo # wayland native
      steam
      # davinci-resolve
      qalculate-gtk # gui for qalc
      gimp-with-plugins
      krita
      inkscape-with-extensions
      alacritty # gpu
      zathura # document viewer
      foot # minimal
      cool-retro-term
      unstable.telegram-desktop
      element-desktop
      discord
      discordo
      djview
      djvulibre
      apvlv # vi-like pdf/epub viewer
      vlc
      transmission
      transmission-gtk
      spotify
      tor-browser-bundle-bin
      slack
      gnome.pomodoro
      solanum # yet another pomodoro
      sageWithDoc
      onionshare
      onionshare-gui
      unstable.obsidian
      obs-studio
      gnome.cheese # webcam
      # haskellPackages.ghcup # broken as of 2023-09-05
      qtox
      nyxt
      qutebrowser
      luakit
      vieb
      vimb
    ];
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~ Misc GUI ~~~~~~~~~~~~~~~~~~~~~~~~~
  fonts.fonts = with pkgs; [
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
        wifi.backend = "iwd";
      };
      wireless.iwd = {
        enable = true;
        settings = { Settings = { AutoConnect = true; }; };
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
      autotiling # dynamic tiling
    ];
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # xdgOpenUsePortal = true;
  };
  services.dbus.enable = true;
  # ~~~~~~~~~~~~~~~~~~~~~ System software ~~~~~~~~~~~~~~~~~~~~~~
  environment.systemPackages = with pkgs; [
    # Basics
    bash
    killall
    clang
    coreutils-full # just in case
    coreutils-prefixed # to keep mac compatibility where possible
    curl
    gcc
    git
    gnumake
    go
    less
    lsof
    python3
    wget
    wirelesstools # iw*
    zip
    unzip
    progress # progress status for cp etc
    efibootmgr
    unstable.neovim
    w3m # text based web browser
    usbutils # just in case
    libusb # zsa voyager
    wally-cli # zsa voyager
    # CLI
    file
    bash-completion
    acpi
    nix-bash-completions
    nixpkgs-fmt # nix formatter
    bat # better cat with syntax hl
    croc # send/receive files
    delta # better diffs
    fd # find alternative
    fzf # fuzzy finder
    jq
    ripgrep # better grep

    dig # dns utils
    inetutils # common network stuff
    # GUI
    google-chrome
    okular # document viewer
    # ~~~~~~~~~~~~~~ Screenshots and screen capture ~~~~~~~~~~~~~~
    slurp # select screen region
    grim # screenshot a specified region
    # shotman # grim, but with simple preview afterwards
    swappy # markup wrapper for grim
    flameshot # more bloated swappy
    # wf-recorder # grim but for video
    kooha # gui screen capture
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    waybar # status bar
    eww-wayland # widget (primarily bars)
    wev # wayland event viewer (useful for debug)
    libnotify # notify-send mako
    mako # notifications
    xdg-utils # for default actions on link clicks
    wdisplays # gui display configuration
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    imv # image viewer for terminal workflows
    playerctl # media controls
    swaybg # wallpaper helper
    mpvpaper # video wallpaper
    swww # wp helper + animated wallpaper
    wallutils # bunch of wallpaper related utils
    wbg # stupid simple wp helper
    wpaperd # swaybg+ daemon
    swayidle # idle events
    swaylock # lockscreen


    kanshi
    wlopm
    wlr-randr

    bemenu # wayland clone of dmenu
    tofi # dmenu/rofi replacement (centered)
    j4-dmenu-desktop # .desktop for dmenu
    pavucontrol # gui audio configuration
    mpv # cli media player
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~ Themes ~~~~~~~~~~~~~~~~~~~~~~~~~~
    glib # gsettings (gtk etc)
    qt5ct
    unstable.qt6ct
    adwaita-qt
    adwaita-qt6
    # dracula-theme
    # dracula-icon-theme
    gnome3.adwaita-icon-theme
    # ~~~~~~~~~~~~~~~~~~~~~~~ Sway scripts ~~~~~~~~~~~~~~~~~~~~~~~
    dbus-sway-environment
    configure-gtk
  ];
  # ~~~~~~~~~~~~~~~~~~~~~~~~~ Hardware ~~~~~~~~~~~~~~~~~~~~~~~~~
  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
  '';
  # ~~~~~~~~~~~~~~~~~~~~~~ Misc software ~~~~~~~~~~~~~~~~~~~~~~~
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
