# > man 5 configuration.nix
# > nixos help
{...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];
}
