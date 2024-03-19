# > man 5 configuration.nix
# > nixos help
{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {config = config.nixpkgs.config;};
  user = import ./expr/user.nix;
in {
  imports = [
    ./hardware-configuration.nix

    ./modules/gui.nix
    ./modules/laptop.nix
    ./modules/printers.nix
    ./modules/services.nix
    ./modules/networking.nix
    ./modules/boilerplate.nix
    ./modules/peripherals.nix
    ./modules/overlays.nix
    ./modules/sound.nix

    <home-manager/nixos>
  ];
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
  environment.systemPackages = import ./expr/packages.nix pkgs unstable;
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["v4l2loopback"]; # virtual webcam
  };
  home-manager.users.${user.username} = {
    home.stateVersion = user.stateVersion;
  };
}
