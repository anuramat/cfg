# > man 5 configuration.nix
# > nixos help
{
  config,
  lib,
  ...
}: let
  unstable = import <nixos-unstable> {inherit (config.nixpkgs) config;};
  user = import ./user.nix;
  helpers = import ./helpers.nix lib;
in {
  imports = [
    ./hardware-configuration.nix
    ./modules
    <home-manager/nixos>
  ];
  _module.args = {
    inherit helpers unstable user;
  };
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
  home-manager.users.${user.username} = {
    home.stateVersion = user.stateVersion;
  };
}
