# > man 5 configuration.nix
# > nixos help

{ config, pkgs, lib, ... }:

let
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Sway boilerplate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # TODO make sure we need this, refer to nixos wiki sway page
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
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
  user = import ./user.nix;
in
{
  imports = [
    ./hardware-configuration.nix

    ./boilerplate.nix
    ./peripherals.nix
    ./printers.nix
    ./networking.nix

    <home-manager/nixos>
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~ Basics ~~~~~~~~~~~~~~~~~~~~~~~~~~
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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
  # ~~~~~~~~~~~~~~~~~~~~~~~ Home Manager ~~~~~~~~~~~~~~~~~~~~~~~
  home-manager.users.${user.username} = {
    home.stateVersion = user.stateVersion;
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
  # ~~~~~~~~~~~~~~~~~~~~~~ Misc software ~~~~~~~~~~~~~~~~~~~~~~~
  # TODO restic backups
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  documentation.man.generateCaches = true; # apropos
  virtualisation.docker.enable = true;
  services.syncthing =
    {
      enable = true;
      user = user.username;
      dataDir = "/home/${user.username}"; # parent directory for synchronised folders
      configDir = "/home/${user.username}/.config/syncthing"; # keys and settings
      databaseDir = "/home/${user.username}/.local/share/syncthing"; # database and logs
    };
}
