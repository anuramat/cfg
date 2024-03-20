# > man 5 configuration.nix
# > nixos help
{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {inherit (config.nixpkgs) config;};
  user = import ./user.nix;
in {
  imports = [
    ./hardware-configuration.nix
    ./modules
    <home-manager/nixos>
  ];
  _module.args = {
    inherit unstable user;
  };
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
