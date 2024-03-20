# > man 5 configuration.nix
# > nixos help
{config, ...}: let
  unstable = import <nixos-unstable> {inherit (config.nixpkgs) config;};
  user = import ./user.nix;
in {
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./test
    <home-manager/nixos>
  ];
  _module.args = {
    inherit unstable user;
  };
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
  home-manager.users.${user.username} = {
    home.stateVersion = user.stateVersion;
  };
}
