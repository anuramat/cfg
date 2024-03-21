# > man 5 configuration.nix
# > nixos help
{
  config,
  lib,
  ...
}: let
  unstable = import <nixos-unstable> {inherit (config.nixpkgs) config;};
  user = import ./user.nix;
  utils = import ./utils.nix lib;
in {
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./utils.nix
    <home-manager/nixos>
  ];
  _module.args = {
    inherit utils unstable user;
  };
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
  home-manager.users.${user.username} = {
    home.stateVersion = user.stateVersion;
  };
}
