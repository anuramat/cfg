# > man 5 configuration.nix
# or
# > nixos help

{ config, pkgs, lib, ... }:

let
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Sway boilerplate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
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

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
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
        gsettings set $gnome_schema gtk-theme 'Dracula'
      '';
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "anuramat-t480"; # Define your hostname.

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Etc/GMT-6"; # WARN inverted

  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # some more boilerplate from wiki https://nixos.wiki/wiki/Printing
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # I don't fucking know what this one does, but
  # wiki says this is required
  sound.enable = true;

  # TODO uncomment
  #services.thermald.enable = true;
  #services.tlp.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
    HandlePowerKeyLongPress=ignore
    HandleSuspendKey=suspend
    HandleHibernateKey=suspend
    HandleLidSwitch=suspend
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=ignore
  '';
  programs.kdeconnect.enable = true;
  programs.light.enable = true;
  users.users.anuramat = {
    description = "Arsen Nuramatov";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    packages = with pkgs; [
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CLI ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qrcp # send files to mobile over Wi-Fi using QR
        exercism # CLI for exercism.org
        ripgrep-all # grep over pdfs etc
        zoxide # better cd
        difftastic # syntax aware diffs
        # ~~~~~~~~~~~~~~~~~~~~~~ File managers ~~~~~~~~~~~~~~~~~~~~~~~
        # TODO choose one?
        ranger
        nnn
        broot
        xplr
        # ~~~~~~~~~~~~~~~~~~~~~~~~ Languages ~~~~~~~~~~~~~~~~~~~~~~~~~
        nodejs_20
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
        tree # not really needed, use "exa --tree" instead
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
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GUI ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qalculate-gtk # gui for qalc
        gimp-with-plugins
        kitty
        alacritty
        foot
        telegram-desktop
        element-desktop
        syncthing
        discord
        discordo
        djview
        djvulibre
        apvlv
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
        obsidian
        obs-studio
# haskellPackages.ghcup # broken as of 2023-09-05
        ];
  };
  virtualisation.docker = {
    enable = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  services.xserver = {
    layout = "us,ru";
    # xkbVariant = "workman,";
    xkbOptions = "ctrl:swapcaps,altwin:swap_lalt_lwin,grp:alt_shift_toggle";
  };

  environment.systemPackages = with pkgs; [
    # Basics
    bash
    killall
    clang
    coreutils-full
    curl
    gcc
    git
    gnumake
    go
    less
    python3
    wget
    # CLI
    bash-completion
    nix-bash-completions
    nixpkgs-fmt # nix formatter
    bat # better cat with syntax hl
    croc # send/receive files
    delta # better diffs
    exa # better ls
    fd # find alternative
    fzf # fuzzy finder
    ripgrep # better grep
    # GUI
    chromium
    firefox
    okular # document viewer
    # Desktop environment
    i3status     # status line generator
    wev          # wayland event viewer
    grim         # screenshot
    slurp        # select area for screenshot
    mako         # notifications
    xdg-utils    # for opening default programs when clicking links
    wdisplays    # gui display configuration
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wayland
    waybar
    swayidle     # idle events
    swaylock     # lockscreen
    bemenu       # wayland clone of dmenu
    glib         # gsettings (gtk etc)
    pavucontrol  # gui audio configuration
    # unchecked TODO
    dbus-sway-environment
    configure-gtk
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
