# > man 5 configuration.nix
# > nixos help
_: {
  imports = [
    ./hardware-configuration.nix
    ./common
  ];
}
