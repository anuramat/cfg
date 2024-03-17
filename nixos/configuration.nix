# > man 5 configuration.nix
# > nixos help

{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
  user = import ./user.nix;
in
{
  imports = [
    ./hardware-configuration.nix

    ./modules/gui.nix
    ./modules/laptop.nix
    ./modules/printers.nix
    ./modules/services.nix
    ./modules/networking.nix
    ./modules/boilerplate.nix
    ./modules/peripherals.nix

    <home-manager/nixos>
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  environment.systemPackages = import ./packages.nix pkgs unstable;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  home-manager.users.${user.username} = {
    home.stateVersion = user.stateVersion;
  };
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
}
