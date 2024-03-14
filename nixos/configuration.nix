# > man 5 configuration.nix
# > nixos help

{ config, pkgs, lib, ... }:

let
  username = "anuramat";
  fullname = "Arsen Nuramatov";
  hostname = "anuramat-t480";
  timezone = "Etc/GMT-5";
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

        # "application/pdf" = [

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
      systemPackages = import ./packages.nix pkgs unstable;
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
