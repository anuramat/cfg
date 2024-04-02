# > man 5 configuration.nix
# > nixos help
{...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
}
